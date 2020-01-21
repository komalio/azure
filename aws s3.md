# Lab 3: Create Amazon Simple Storage Service (S3)

## Table of Contents

[Overview](#overview)

[Pre-Requisites](#pre-requisites)

[Exercise 1: Login to AWS Console](#exercise-1-login-to-aws-console)

[Exercise 2: Getting Started with Amazon Simple Storage Service](#exercise-2-getting-started-with-amazon-simple-storage-service)
    
[Exercise 3: Access Control List Bucket Permissions](#exercise-3-access-control-list-bucket-permissions)

## Overview

The main aim of this lab is to Create a Storage Bucket and Upload Object to the Bucket, Provide Aceess Control List Permissions to the Bucket.

### Scenario and Objectives

   * Create a Bucket

   * Add an Object to Bucket

   * View an Object

   * Move an Object

   * Delete an Object and Bucket

  * Provide ACL Bucket Permissions

## Pre-Requisites

 Familiar with AWS Console

## Exercise 1: Login to AWS Console

1. Navigate to **chrome** on the right pane, you should see AWS console page.

2. Go to top right corner of the AWS page in the browser, click on **My Account** and in the dropdown, select AWS Management console.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login1.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

3. Use below credentials to login to AWS console.

 **Account ID:** {{Account-ID}}

 **IAM username:** {{IAM-UserName}}

 **Password:** {{IAM-Password}}

 **Region:** {{Location}}

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login2.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)

4.	Enter **Account ID** from the above information, then click on Next.

5.	Enter **IAM username** and **Password** from the above information and click on Sign In.

6.	Once you provide all that information correctly you will see the AWS-management console dashboard.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/Lab1/login3.png?st=2019-11-04T11%3A39%3A04Z&se=2022-11-05T11%3A39%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=Sa56prMYw1XzwuxPcVbvr50Hzgx5ZI3vwKu4OLIo79s%3D)
 

## Exercise 2: Getting Started with Amazon Simple Storage Service

* Amazon Simple Storage Service (Amazon S3) is storage for the Internet. You can use Amazon S3 to store and retrieve any amount of data at any time, from anywhere on the web.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/3.png?st=2019-11-12T06%3A27%3A55Z&se=2022-11-13T06%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=D4p5rMFI2TXC0q8qx58Hwni%2BMUcGIHkF3CkyQtnGrxg%3D)

**Buckets:**

* A bucket is a container for objects stored in Amazon S3. Store an infinite amount of data in a bucket.
* Upload as many objects as you like into an Amazon S3 bucket. Each object can contain up to 5 TB of data.

**Objects:**

* Objects are the fundamental entities stored in Amazon S3. Objects consist of object data and metadata.
* The data portion is opaque to Amazon S3. The metadata is a set of name-value pairs that describe the object.
**Note:** An object is uniquely identified within a bucket by a key (name) and a version ID.



**Create a Bucket:**

1. Choose Create bucket.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/1.PNG?st=2019-11-15T05%3A27%3A04Z&se=2022-11-16T05%3A27%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dfiGmRQBdcXAYU%2Bh3pBrho2G4VgBsB2nsfHbQzo%2B3KM%3D)

**Bucket Name:** Type a Unique name

**Region:** {{Location}} 

2.	Choose **Create.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/2.PNG?st=2019-11-15T05%3A28%3A40Z&se=2022-11-16T05%3A28%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=uMmd0yMDd%2BGgQPeW4V0gkYh54TrOJZWxOS1dlmiM8xo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/4.PNG?st=2019-11-15T05%3A29%3A05Z&se=2022-11-16T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=Urs%2BFkcGZGe6wLp7K76vPkw0cht7UI262eCZaYv9elA%3D)

**Add an Object to a Bucket:**

1. In the Bucket name list, choose the name of the bucket that you want to upload your object to.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/5.PNG?st=2019-11-15T05%3A29%3A29Z&se=2022-11-16T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=kdV2X%2BFSbWPdkQh5tLFUEKAb4rHfaJf7BSl%2F%2F5UjPZg%3D)

4. Choose **Upload.**

    **a.** Or you can choose Get started.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/6.PNG?st=2019-11-15T05%3A29%3A52Z&se=2022-11-16T05%3A29%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=sKdfSKbG66JdUnB7np8sGe4pHp9fdpcb%2Fai5PADS3lg%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/7.PNG?st=2019-11-15T05%3A30%3A18Z&se=2022-11-16T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dnj%2FvCbRFsiuV21QfD88T631Ay8xGU3biqNWlMvYEO8%3D)

5. Open the below Url in Chrome and save it in folder.

   https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/example.png?st=2019-11-15T05%3A44%3A24Z&se=2022-11-16T05%3A44%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=QguqN%2F8I4Gj7XCNj%2BK7FWeeKnZEZfJr8i6HTmV4HXb8%3D

6. In the Upload dialog box, choose Add files to choose the file to upload.

7. Choose a file to upload from saved folder, and then choose Open.

8. Choose Upload.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/7.PNG?st=2019-11-15T05%3A30%3A18Z&se=2022-11-16T05%3A30%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=dnj%2FvCbRFsiuV21QfD88T631Ay8xGU3biqNWlMvYEO8%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/8.PNG?st=2019-11-15T05%3A31%3A08Z&se=2022-11-16T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=hU2TdEeT%2BE%2F2dPbFaEOhp8lw2qc8PCC%2B%2Fil5Y2%2Fq2BI%3D)


**View an Object:**

9. In the Bucket name list, choose the name of the bucket that you created.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/9.PNG?st=2019-11-15T05%3A31%3A33Z&se=2022-11-16T05%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=k%2FTD%2B%2B9D9nU2wRXpGNRNWU0HbUHQXpunKnIhCKBe1qA%3D)

10. In the Name list, select the check box next to the object that you uploaded, and then choose Download on the object overview panel.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/10.PNG?st=2019-11-12T06%3A31%3A49Z&se=2022-11-13T06%3A31%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=7L9fF4o3oj61DLBa4Sy9xizsKCtzeidc28PDm7P9lMU%3D)

**Move an Object:**	

11.	In the Bucket name list, choose the name of the bucket that you created.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/5.PNG?st=2019-11-15T05%3A33%3A56Z&se=2022-11-16T05%3A33%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=0z7Vst4igg0eUY1HrfVcaDu7EzCOzd8XhoH2vdJuxzg%3D)

12. Choose Create Folder, type **new-folder** for the folder name, choose None for the encryption setting for the folder object and then choose **Save.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/11.PNG?st=2019-11-12T10%3A07%3A52Z&se=2022-11-13T10%3A07%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=DlPwZTNv5vg1ioAKA8ZeS4IGjvHyXYhkuC%2F%2FOskrKGc%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/12.PNG?st=2019-11-12T10%3A08%3A59Z&se=2022-11-13T10%3A08%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=%2FzmozeQygWrJqfaAyKXgaS8tDIim7SmFg2PSrbZSyus%3D)

13.  In the Name list, select the check box next to the object that you want to **copy,** choose More, and then choose Copy.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/13.PNG?st=2019-11-15T05%3A35%3A59Z&se=2022-11-16T05%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TAW%2Fz5mzEiYBAlTkPDC5Jt%2BBCD1zN%2FJq6ldSzLc48lw%3D)

14.	In the Name list, choose the name of the folder **new-folder**.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/14.PNG?st=2019-11-12T10%3A10%3A42Z&se=2022-11-13T10%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=J0CWWfohe%2FyZ69HHUYZTViVYVc4kLvp%2B2KbHaSI4ZjU%3D)

15.	Choose More, and then choose **Paste.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/15.PNG?st=2019-11-12T10%3A11%3A14Z&se=2022-11-13T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=TpWfZjxx%2FZ1PQVxrwi8%2BlnYox69RSueekxIowcfPCPo%3D)

16.	Choose **Paste.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/16.PNG?st=2019-11-12T10%3A11%3A54Z&se=2022-11-13T10%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4M1GGkSq40txbVohp1tXcVKZyZfav0POFIOc0QhSAro%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/17.PNG?st=2019-11-12T10%3A12%3A17Z&se=2022-11-13T10%3A12%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=CoRXd4S9bQ1WmoyS5U9NeKwXuVI9r4MgV0F1SS1Dh%2BI%3D)

## Exercise 3: Access Control List Bucket Permissions

**Bucket Policies:**

* Bucket policies provide centralized access control to buckets and objects based on a variety of conditions, including Amazon S3 operations, requesters, resources, and aspects of the request (for example, IP address).

**Access Control Lists:** 

   Access Control lists are used to grant basic read/write permissions to other AWS accounts.

1. In the Bucket name list, choose the name of the bucket that you want to set permissions for.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/5.PNG?st=2019-11-12T10%3A15%3A31Z&se=2022-11-13T10%3A15%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=g4MOWh3yIAKJbiZos3Yh19mcpbY5O9U3gN4aQ4ltyqg%3D)

2. Choose Permissions, and then choose Access Control List.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/20.PNG?st=2019-11-12T10%3A17%3A25Z&se=2022-11-13T08%3A32%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GdFqnc2Y6UCvaDsNUQyfz5QjJU4D8qr6pEacZn3vKNQ%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/21.PNG?st=2019-11-12T10%3A18%3A05Z&se=2022-11-13T10%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=eGk%2ByiVVXR4b1xtZlCRZPsVRng4WgP5iH0JImg1%2ByyI%3D)

3. Access for your AWS accounted root user
   
    * To change the owner's bucket access permissions, under **Access for your AWS accounted root user,** choose **Your AWS Account (owner).**

    * Select the check boxes next to the permissions that you want to grant to the user, and then choose Save.


![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/22.PNG?st=2019-11-12T10%3A18%3A39Z&se=2022-11-13T10%3A18%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=00dc6wAyQCGjk5LZecYn%2BhEmIqKFnEXI8MfwVH492rE%3D)

**Note:** The Root user able to give the permissions others not able to give the permissions.

4.	Access for other AWS accounts

    If you want to give permissions to different AWS Accounts choose **Add Account** and enter the all details

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/23.PNG?st=2019-11-12T10%3A19%3A18Z&se=2022-11-13T10%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=4%2Bv8ocYoHrD2NgJqwEFxqmHkN0CJxyhHot50juYl0jM%3D)

5. Public access

    * Select the check boxes next to the permissions that you want to grant to the user, and then choose **Save.**

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/24.PNG?st=2019-11-12T10%3A19%3A43Z&se=2022-11-13T10%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=FN5%2BnO%2By8dBfkrluR00pBAbmYmQVBIQntNQLvv%2Bn4Xo%3D)

6. If you want to **Open all public access** edit the Block all public access and uncheck the dialouge box and save it.

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/25.PNG?st=2019-11-15T07%3A42%3A18Z&se=2022-11-16T07%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=48p%2FLVm4U%2BIXwjPQS2vB1TVP%2BGfA6qdJEYvXo%2F%2BXUqo%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/26.PNG?st=2019-11-15T07%3A42%3A37Z&se=2022-11-16T07%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=pKhkL%2Bjy0s1DbXOfofr%2FygcPiIn%2BZxcIPQHqDBHyF6g%3D)

![alt text](https://qloudableassets.blob.core.windows.net/aws-fundamentals/AWS%20S3/27.PNG?st=2019-11-15T07%3A42%3A57Z&se=2022-11-16T07%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=X5f9mKCdHP0u9VQITa8UxW8LPVsU1MMu48VDkqM97n0%3D)


**Result:** Created the Bucket and uploaded the Object to the Bucket and given ACL permissions.
