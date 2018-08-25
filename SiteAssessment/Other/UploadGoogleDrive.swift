//
//  UploadGoogleDrive.swift
//  SiteAssessment
//
//  Created by OMGdadada on 2018/7/30.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import Foundation

enum GDriveError: Error {
    case NoDataAtPath
}

class UploadGoogleDrive {
    
    private let service: GTLRDriveService
    
    init(_ service: GTLRDriveService) {
        self.service = service
    }
    
    public func listFilesInFolder(_ folder: String, onCompleted: @escaping (GTLRDrive_FileList?, Error?) -> ()) {
        search(folder) { (folderID, error) in
            guard let ID = folderID else {
                onCompleted(nil, error)
                return
            }
            self.listFiles(ID, onCompleted: onCompleted)
        }
    }
    
    private func listFiles(_ folderID: String, onCompleted: @escaping (GTLRDrive_FileList?, Error?) -> ()) {
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 100
        query.q = "'\(folderID)' in parents"
        
        service.executeQuery(query) { (ticket, result, error) in
            onCompleted(result as? GTLRDrive_FileList, error)
        }
    }
    
    public func uploadIntoFolder(_ ID: String, filePath: String, MIMEType: String, onCompleted: ((String?, Error?) -> ())?) {
        self.upload(ID, path: filePath, MIMEType: MIMEType, onCompleted: onCompleted)
    }
    
    //创建母文件夹
    public func uploadParentFolder(_ folderName: String, onCompleted: ((String?, Error?) -> ())?) {
        search(folderName) { (folderID, error) in
            if let ID = folderID {
                print("母文件夹已存在，文件夹ID:\(ID)")
                onCompleted?(ID, error)
            } else {
                self.createFolder(folderName, onCompleted: { (folderID, error) in
                    guard let ID = folderID else {
                        onCompleted?(nil, error)
                        return
                    }
                    print("创建母文件夹，文件夹ID:\(ID)")
                    onCompleted?(ID, error)
                })
            }
        }
    }
    
    
    public func uploadFile(_ folderName: String, onCompleted: ((String?, Error?) -> ())?) {
        let FolderName = folderName.split(separator: "/")
        let first_FolderName = FolderName[0]
        var first_FolderName_ID = ""
        let last_FolderName = FolderName[1]
        search(String(first_FolderName)) { (folderID, error) in
            if let ID = folderID {
                first_FolderName_ID = ID
                print("获取文件夹ID:\(first_FolderName_ID)")
                self.searchFromFolder(String(last_FolderName), first_FolderName_ID) { (folderID, error) in
                    if let ID = folderID {
                        print("已经有子文件夹\(ID)")
                        onCompleted?(ID, error)
                    } else {
                        print("添加子文件夹\(String(last_FolderName))")
                        self.createSubfolder(String(last_FolderName),first_FolderName_ID,onCompleted: { (folderID, error) in
                            guard let ID = folderID else {
                                onCompleted?(nil, error)
                                return
                            }
                            print("添加子文件夹\(ID)")
                            onCompleted?(ID, error)
                        })
                    }
                    
                }
            }
        }
    }
    
    
    
    private func upload(_ parentID: String, path: String, MIMEType: String, onCompleted: ((String?, Error?) -> ())?) {
        
        guard let data = FileManager.default.contents(atPath: path) else {
            onCompleted?(nil, GDriveError.NoDataAtPath)
            return
        }
        
        let file = GTLRDrive_File()
        file.name = path.components(separatedBy: "/").last
        file.parents = [parentID]
        let uploadParams = GTLRUploadParameters.init(data: data, mimeType: MIMEType)
        uploadParams.shouldUploadWithSingleRequest = true
        
        //uploadParams.shouldUploadWithSingleRequest = true
        
        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: uploadParams)
        query.fields = "id"
        
        self.service.executeQuery(query, completionHandler: { (ticket, file, error) in
            onCompleted?((file as? GTLRDrive_File)?.identifier, error)
        })
    }
    
    public func download(_ fileID: String, onCompleted: @escaping (Data?, Error?) -> ()) {
        let query = GTLRDriveQuery_FilesGet.queryForMedia(withFileId: fileID)
        service.executeQuery(query) { (ticket, file, error) in
            onCompleted((file as? GTLRDataObject)?.data, error)
        }
    }
    
    public func search(_ fileName: String, onCompleted: @escaping (String?, Error?) -> ()) {
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 1
        query.q = "name contains '\(fileName)'"
        
        service.executeQuery(query) { (ticket, results, error) in
            onCompleted((results as? GTLRDrive_FileList)?.files?.first?.identifier, error)
        }
    }
    //从文件夹内查找
    public func searchFromFolder(_ fileName: String,_ ParentFolder_ID:String ,onCompleted: @escaping (String?, Error?) -> ()) {
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 1
        query.q = "name contains '\(fileName)' and '\(ParentFolder_ID)' in parents"
        
        service.executeQuery(query) { (ticket, results, error) in
            onCompleted((results as? GTLRDrive_FileList)?.files?.first?.identifier, error)
        }
    }
    
    public func createFolder(_ name: String, onCompleted: @escaping (String?, Error?) -> ()) {
        let file = GTLRDrive_File()
        file.name = name
        file.mimeType = "application/vnd.google-apps.folder"
        
        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: nil)
        query.fields = "id"
        
        service.executeQuery(query) { (ticket, folder, error) in
            onCompleted((folder as? GTLRDrive_File)?.identifier, error)
        }
    }
    
    //建立子文件夹
    public func createSubfolder(_ name: String,_ last_FolderName_ID: String, onCompleted: @escaping (String?, Error?) -> ()) {
        let file = GTLRDrive_File()
        file.name = name
        file.mimeType = "application/vnd.google-apps.folder"
        file.parents = [last_FolderName_ID]
        let query = GTLRDriveQuery_FilesCreate.query(withObject: file, uploadParameters: nil)
        query.fields = "id"
        
        service.executeQuery(query) { (ticket, folder, error) in
            onCompleted((folder as? GTLRDrive_File)?.identifier, error)
        }
    }
    
    public func delete(_ fileID: String, onCompleted: ((Error?) -> ())?) {
        let query = GTLRDriveQuery_FilesDelete.query(withFileId: fileID)
        service.executeQuery(query) { (ticket, nilFile, error) in
            onCompleted?(error)
        }
    }
}
