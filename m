Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D32D0C92;
	Mon, 12 Jan 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219401; cv=none; b=KId2ZzpaS4lhsY/tpK0Htn6AvL+HX82j9w+HsDgHlFXgx6yE6EyPD9ZvNvDOWb0NqrkUeP0cBiqjYXdr8A4M19d8Ssmk7PyDRtyz2lHe3lpd3Ehfw1VYZAKSDbUHzh2Snp7qezEKr7vY2oY4I6XUDi5CnONQgySYwWXZX04vvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219401; c=relaxed/simple;
	bh=eo6yeQ9o4qroYxRi5vKMlqK6zBlq0XOFl6qhN3YX0BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiXGh+KYJvLDMPXvUWULa0oA5FG9JKscG9D3bkvQ0SW3kGwufWSVg5OlTAmkj9e4+e4amGekv7CKRX86w74kGRz3lcs1DPG7jMNPVy8p4/pB5XAA9sYx6RudhkhaOIS0I/BiHIEtlbEVyDwTIfZ2DDlD63S1X+DfyE/GIwDe4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQTT8a+/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQTT8a+/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BNh3gV002417;
	Mon, 12 Jan 2026 12:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5z/OGh
	/9u2vGicbaWmcmD41w5KKx3otx3GHpitVDywA=; b=dQTT8a+/1RNJTa2jL94Pft
	2s+geejKtHLtxQR1OWXP0Alyjn5c6x1/llwY0OP27JScdx1rPH20NNIKeusAgvTj
	QSYwPPwZFc1S+fLynnT37eioynJVNacYY5MtOCfjmyfbathmigbyNrmFF7ORyVxU
	/hSD2bg8hGyyFY5oSU9jdvBSoczr2uAkbMrqGWYunyMaMs1t2ZQN8tGrwRN7RLAY
	Z/RTRq4lzYflBcIuNgv0IwCUp8J3WbeQuUVD0dhQ5b97NCval9JkYhFQoWqjQeiy
	zFh6aRy4OkOlMemjSDJ44Z74EIXeDILOnRNWN+sSarMD0aj83qFxQda3zjVvGwqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeppuw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:03:06 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CC366A017422;
	Mon, 12 Jan 2026 12:03:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeppuw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:03:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CBQubU031294;
	Mon, 12 Jan 2026 12:03:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1deg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 12:03:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CC31iP40698312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 12:03:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7616720043;
	Mon, 12 Jan 2026 12:03:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B8D20040;
	Mon, 12 Jan 2026 12:02:58 +0000 (GMT)
Received: from [9.124.219.252] (unknown [9.124.219.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 12:02:58 +0000 (GMT)
Message-ID: <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
Date: Mon, 12 Jan 2026 17:32:58 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Uladzislau Rezki <urezki@gmail.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        tglx@linutronix.de, peterz@infradead.org, srikar@linux.ibm.com
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aWTIDGQ1_NYeO4iU@pc636>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=6964e2fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=viNbSOD8kPG4UGe-rqcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qZNNhGZnr9tVNFJsb3Vwrjg9AtOu0zrZ
X-Proofpoint-ORIG-GUID: T93c_kHy7eqzPRxJUQphXFaGHW4Me6jG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5NCBTYWx0ZWRfX0wFt9U1a7H+h
 mlXyM/Fe3mfMLgPYfG5xQG1bYQZ5C2Dfmv3oTq2AVOqB0qMb4QDWTTCvLV4GWNdy9mPshN1/fto
 PW1mWsrz7i3Z4qpydls0PxLhfdAuRCSp7wUCNdYz39RFco7cfSRzrE2RbclKWrHrmhbHWkbEnWc
 suj6hIL9K9v6vVCFaCDv11w1COAicukH+cMzp3cjXPgXfqH+Yr+aKlXH7FYYzPim+jKt5l8CoPc
 iF9pCGmWB08ew9iujwrJ193G4/Bdi2OHQsYHKO7FKUhmVVEf61aX8FReQ7NmJjvY+sWE/Ss+x2V
 uzFICohNUtnlh4+fiZkqhqadGfUGhiCT7vrhy/cCuY/qG9uA1kUmANyMDx1K6m240DvDNWK/ErC
 /vajBYRN3i5CBTd5Q8Hy/pmvCIB9B6njqhlgvLZXSfPyK5sRcK1G4woAaeSPFHoNdb5ShUbZ94m
 PQFaHI73Mi5c4BrhE6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120094


Hi Vishal. Thanks for the patch.

On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
>> Bulk CPU hotplug operations—such as switching SMT modes across all
>> cores—require hotplugging multiple CPUs in rapid succession. On large
>> systems, this process takes significant time, increasing as the number
>> of CPUs grows, leading to substantial delays on high-core-count
>> machines. Analysis [1] reveals that the majority of this time is spent
>> waiting for synchronize_rcu().
>>
>> Expedite synchronize_rcu() during the hotplug path to accelerate the
>> operation. Since CPU hotplug is a user-initiated administrative task,
>> it should complete as quickly as possible.
>>
>> Performance data on a PPC64 system with 400 CPUs:
>>
>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
>> Before: real 1m14.792s
>> After:  real 0m03.205s  # ~23x improvement
>>
>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
>> Before: real 2m27.695s
>> After:  real 0m02.510s  # ~58x improvement
>>
>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
>>
>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
>>
> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> your "expedited switch" improvement.
> 

Hi Uladzislau.

Had a discussion on this at LPC, having in kernel solution is likely
better than having it in userspace.

- Having it in kernel would make it work across all archs. Why should
   any user wait when one initiates the hotplug.

- userspace tools are spread across such as chcpu, ppc64_cpu etc.
   though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
   We will have to repeat the same in each tool.

- There is already /sys/kernel/rcu_expedited which is better if at all
   we need to fallback to userspace.
