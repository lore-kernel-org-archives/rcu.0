Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468780;
	b=K9p7BT36FNHmUnQ91DpH94S6wMjVW0iKaxT1pp7XoYnZO6qnCSLILnuAmfXGRx4XGbVx
	 dM0kQCu4+hUO7joMiiyFEn9tRCuDWfTX78GXP9U71+T1zXXAtmMwJ2q03DAEPfDkiLWLQ
	 fYKeyI971Y9a5X4vJdGzk/iu5i5rTYBq05GQkerPjCXr9bu0n/pgT3Pr2feRiIhHfASq8
	 4sv7m3CrV1fdsBzqfa5gtz0jz+mBMJ3Fb2rCEDksLivs4H5T3oFdKeBFOG1R5ilTspO8g
	 GwK4npjZYAdnPAVk8h/Hd1GHlTKws3eWlMZqmxsu9Sj9Mc8O8pQVPIZP5AlkoD1YB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468780;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GKD/hRicdD0Zp5EXTL9bYM7Gn04M37SfSg+biuP32OI=;
	b=NyQABmybhP2SW+kDIWnV/7PeBnqQhMG0OPc51h1PWMeS7FXw23nH0GG/rlFqMVtU/eHq
	 rZwFeXkrzFShjXPDSz81ffxtRxwJJlWxQ3N4FAhO/7n9PhnyWXlRgttO0vW6r9barDOFH
	 g4AbPypTzNOiHzc5YNkuvVfbmsDDISZqwkZWaYfqe4QYPswYd1S9rZm7Uvg9wZuG011wn
	 H2AiCadadyQRRglFmjdw6nTVO8BAKtkamicA/bAKriHjErmd1LR14LPGbHLArTcDGmtaB
	 MX9wSuWToGWaZYld5ZOFhdhE/a0JS2NpmxrwhGml3gvO0s+XML9luk1dpE2fVO6Dlww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VwFYMeCF;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C92606A31C;
	Thu, 12 Nov 2026 07:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VwFYMeCF
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iEAV2857600;
	Thu, 12 Nov 2026 07:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GKD/hR
	icdD0Zp5EXTL9bYM7Gn04M37SfSg+biuP32OI=; b=VwFYMeCFwpn6RuhIgKn3qS
	ZV9WrYlgwbAFOo3eFfe4OZC2J8WuHKqckZJ1XeWjW8b93hWQNjFU8z3Upitmdq8I
	oVN9g8QcRh3xQ2eCtFyC4NlBRYji+6Qo0doUjzGEwqOH0pOhsIDM6BU0A7/se28i
	0u6UBR5756SiLhSmTFO6pdggvqOlryJmMTsxm2k68eWf2i5x492LpQFvGI9ZxF2T
	qNrQzYH8XdUUotC6eFDvsdOfTUeBkYk7QPl8kXeaVROh7r5jPmAvHyDMUedl/IIY
	B/nJnS5u8s6Ha93Z7gWt/02zMp5Sz4pxF8nRZVj3VZzTkHoA9OkhB85n2kpJpiZA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv54wb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:32:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zmb63145599;
	Thu, 12 Nov 2026 07:32:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51wgxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:32:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC7WSO352166970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 07:32:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758A520040;
	Thu, 12 Nov 2026 07:32:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC7D620043;
	Thu, 12 Nov 2026 07:32:24 +0000 (GMT)
Received: from [9.124.215.130] (unknown [9.124.215.130])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 07:32:24 +0000 (GMT)
Message-ID: <974cf626-37b6-4497-94e8-b9a443733dc0@linux.ibm.com>
Date: Thu, 12 Nov 2026 13:02:23 +0530
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] cpuhp: Expedite RCU when toggling system-wide SMT
 mode
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: paulmck@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, aboorvad@linux.ibm.com,
        boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, urezki@gmail.com,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir@linux.ibm.com
References: <20260615042514.694993-2-vishalc@linux.ibm.com>
 <20260615042514.694993-4-vishalc@linux.ibm.com>
 <f1a04d2f-367e-4be8-b313-31a73e15bcd0@paulmck-laptop>
 <4bd12c51-414d-49b5-8fce-2a6e73a479fa@linux.ibm.com>
 <e143d10e-69b1-455d-90b3-5f29a9482c15@linux.ibm.com>
 <cda6b648-2c3a-4b01-8126-933056f221a9@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <cda6b648-2c3a-4b01-8126-933056f221a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX7IQvO7lwDbo9
 mQVWWgXjs4jxtgDIavGH2ajZsKClwd8J1VQt7cFOOxoHIlErs05sRLWwS/SjQQX0ltgO2gRZPVW
 UOjYyuE/cwbsyBlRIwZ+5qgfWWjIQxs=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af56b91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=7ipKWUHlAAAA:8 a=Ov_r3akWpeJuxPGQIgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gpc5p9EgBqZVLdJeV_V1:22
X-Proofpoint-GUID: nzGle3TTZ6k1TwgtPCc4QLDJrGvL4573
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyOCBTYWx0ZWRfX16ydLGVuoz5C
 XzQb+vhsEZB+uxI0AVaC6+HdlQe0LgRegt2xVZG0iG8+MIhk3zUrGyNz2MmnuwSEOqMdmVx/Tyl
 odc8fbrjZ/DB9Tg7He3XXSVQTCzkji1ahgURXHDoNnPSYNM8SjAtJUc1DXIMGp7cQ34oNPbyTYb
 ST/l686GY9X5rM7K26rgfFTE7s5cQemmtFFAk54j3hbhNZwxtty98TgyWAxrKNxMFJSuClsk287
 aeE8KlFKuQuOQnkH5chvAOvYqC9V0bg2B/DU3NImp3stLQyRvoWV7E0SyfHqmcWJTc7zJTz5fXY
 RUeeSoVQl6bwLRfAR7dcNSFl8ZEzh5q5gxFUjoS3vSXYCeiMpAc2/6O61bvxITPhkpnoTh4eQE2
 byatissgikQYxEZ15/NboRfRJh0c1AA4YWiwyEKgfI5NFR0QMG1ZC+izUDk6bG9m7SRAYiGq+pQ
 SkaVdjn/subhdcWdRVw==
X-Proofpoint-ORIG-GUID: -sd2xC3j5Eh2VxDfv3V_Zwo67C7GRNqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120028

Hi Paul, Peter, Ingo, Thomas,


Still seeing need to explicitly expedite during benchmarking
while reading this patch series a while ago, reminded me again that
we still don't have this patch in upstream.

https://lore.kernel.org/all/20261015153331.1872641-1-pasha.tatashin@soleen.com/

>>>>
>>>> I am guessing that you will be taking this up some other path, but if
>>>> you would like it to to via RCU, please let me know.
>>>>
>>>>                             Thanx, Paul
>>>>

Peter, Ingo, Thomas,

Can this go via RCU tree??

>>>
>>> I would prefer this to go via tip tree since main change is in cpu.c
>>>
>>> Thomas, peter,
>>> What do you guys suggest? can this go via tip tree?
>>>
>>> Also, do you have any other review comments on this or test to be done?
>>>
>>
>> Gentle Ping.
>>
>> Thomas, Peter, Ingo, Can this go via tip tree?
>> Do you guys have any comments to be addressed?
>>
>> Or Do you want it to go via RCU tree?
>>
> 
> Gentle Reminder.
> 
> This might have fell through the cracks.
> Are there any concerns still to be addressed?

PS:
I checked it still applies cleanly to tip/sched/core.
