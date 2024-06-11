Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475661D556
	for <rcu@vger.kernel.org>; Tue, 11 Jun 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125843; cv=none; b=XRTumcHkQPhZpakRVhHdCLJuMHinUJLyJcsqpYvw1VPVesLGVX9/dtgl3QVyIJPl2Igih5+/zQUoe5YEaWij8yVin+VlJ5tV35EDVSVeNP41Mk19TlsBWP9kdhNPPshwjNqleeuHnrnarNt8bksO/eS7Vtjm9qKDfa2iDdaaxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125843; c=relaxed/simple;
	bh=cNuS7szjfdH7DlEoLK+f1dgnduydVEytXFCAxvigp64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnqz8cG7H5djOFFLBLLLzMVzYLA0itSWG6kpk6+CQa9/t4dox0kuZlMjI4ik38yLnV6lq7iQW4UmXeYAX6eUgMq39NRG1h+cvvZLusikm0Gzj4+rktjeV09nsztsm2SjU7KBHu6OMZGj/A/WNWZvA7lvhjVaz646F1Ofa9bFrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pauXh4W4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pauXh4W4"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BGv15S018223;
	Tue, 11 Jun 2024 17:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=W
	khCzogMetunFcxMIpgy8HtGPCxJJ8pwk8KUqhgn0po=; b=pauXh4W4xdzZErOVs
	0qEnyDsGm7Zsn7K5/+vCSpzzeDUoia7dCuK4lAoVAenvzwb0llYURy3re7woYE0n
	q7zMDJVxUg7Tb5F0n1NIzoU9y5onsKI6k2jP5Bi0+OXRzPxKruCWOXNMJMQ/XzDI
	2qAsXIE03tUFSKkNhyKJwWP5y6iAzktrQpPufvMWa12pIpgnCInqtBF/vd4W3dJM
	ublULJG6Pt4MYkUWYlOxJrtjaCPAIZZoKw4TNUTy0F80bRiiBb7IxguoFlXv9XLQ
	SIpe58DnWeTnpRqc3OKi0iFe+bc+9xbOeKzejVKzue+9uZIv0v3yYaDzFQOG0UDv
	AnheA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yptj1g1ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:10:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45BFqHYf008711;
	Tue, 11 Jun 2024 17:10:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b36jdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 17:10:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45BHAJeP18481902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:10:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9443058054;
	Tue, 11 Jun 2024 17:10:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3205A5804E;
	Tue, 11 Jun 2024 17:10:16 +0000 (GMT)
Received: from [9.43.77.165] (unknown [9.43.77.165])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Jun 2024 17:10:15 +0000 (GMT)
Message-ID: <f93a4963-f524-4ca3-9046-28bc65408721@linux.ibm.com>
Date: Tue, 11 Jun 2024 22:40:13 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix namespace removal list
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240611163955.GA12787@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRGrp8QFURFWsqPYZTpcxCOwJyki0zqX
X-Proofpoint-ORIG-GUID: VRGrp8QFURFWsqPYZTpcxCOwJyki0zqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=901 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110118



On 6/11/24 22:09, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 08:20:55AM -0700, Keith Busch wrote:
>>  	mutex_lock(&ctrl->namespaces_lock);
>>  	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>> -		if (ns->head->ns_id > nsid)
>> -			list_splice_init_rcu(&ns->list, &rm_list,
>> -					     synchronize_rcu);
>> +		if (ns->head->ns_id > nsid) {
>> +			list_del_rcu(&ns->list);
>> +			list_add_tail_rcu(&ns->list, &rm_list);
>> +		}
> 
> Is this actually valid for a (S)RCU protected list?  If the entry gets
> added to the new list before the grace period has completed, we could
> trick a concurrent traversal into following the new list unless I'm
> mistaken (although chances I'm mistaken on RCU corner cases aren't that
> low..).
> 
> 
I think we need synchronize_srcu() before we add deleted ns to rm_list.

Thanks,
--Nilay
