Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B52D0C95;
	Tue, 13 Jan 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316051; cv=none; b=VZ8uzX8q/lCFwKNccoBGW31uIKvUayArDw4iGg+0ifN+hQxovgIETZr3L69zQrH2KBRscFF9SLdNmP+OD7REMHb94jYHzoH3FlLt1CvyjBXt5oHSc0ANSkkzEQMIaXjBLBdFJVXLvRTHQMbB88U2798w4+5w7DTpnIXBtaaOzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316051; c=relaxed/simple;
	bh=fFhYQxrnUA7SbxNT0ZjqinEGupEedW2XfiVRnyjIf8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJLpq5nrtEKKNIbJsT42UBOOtJZQNGRoDFGjAwRC45/GmioKlZmgX5uLm8AwjIEcSLaLF3h9/8beiOckWum7+XqMkckbzZKXMk7eNQgikpRp6ri3i8AsXgT1Zvz4gb34UFt/H/sWfcOH8XE8vFBrf2xhOqO9aV1TLm3GgUu3l9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iUJnO7yV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iUJnO7yV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D3lAdJ003205;
	Tue, 13 Jan 2026 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g2kzbQ
	Bf3/2/cQ9oFBc2eNwwzbz6gtBDLtbNzbJuiG0=; b=iUJnO7yVft86LB6hD9xxq4
	jl6idW9njwI6Y09op4ts5inBKbnXRDjUYbPIMciFN+nCwiMbKswvOx0hRZ2Oue9/
	Lpxqi4xxkkGD3VUxkAoyO5Vm0GNGIgEh/t6kFdOpAgm0NgMvb9SYgC7ySS2FPjch
	pICcY0sTB7E4W2Wb2Z9qjCGoja+pNLtqIEFcGu8/dXQW8DnSOXJKLbr4sN0D7VGG
	wY2B7Ldxyq49qjZ5q2KBzL2p2JA0HCZT5VjgKTU0tCeC5bzA3F3j8EVSESazuWnz
	klVL0xY3FnpiFpbBGfY2Wm6brClcF1rp4ztVrn0alqbj+KQ1U2CWhqhbRQR75TKA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h4tyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 14:53:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DEhLbu026956;
	Tue, 13 Jan 2026 14:53:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h4tyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 14:53:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DD6Ll5014251;
	Tue, 13 Jan 2026 14:53:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fy4uba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 14:53:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60DErXUJ27525730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 14:53:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8956C20043;
	Tue, 13 Jan 2026 14:53:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 822112004B;
	Tue, 13 Jan 2026 14:53:30 +0000 (GMT)
Received: from [9.39.17.221] (unknown [9.39.17.221])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 14:53:30 +0000 (GMT)
Message-ID: <a746ab66-79ac-4cdc-91e8-07814e172a8b@linux.ibm.com>
Date: Tue, 13 Jan 2026 20:23:29 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "srikar@linux.ibm.com" <srikar@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636> <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan> <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <aWUqtX2PGDOZUaDW@milan> <D5086AE0-7158-49C4-8511-47F99021B2AE@nvidia.com>
 <aWY4LQZrudJ4SB8G@pc636> <B077EC99-57EC-48B8-9B71-237A7A95DFE2@nvidia.com>
 <aWZUAhbMV_BHamr_@milan> <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <6d05f9ea-fc4f-4115-a416-8e779f17e0fb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8u0ZuJ2GvY2KKYG6EVXhJCkPsbJUUm1C
X-Proofpoint-ORIG-GUID: sjhsg6RNc39E8qLqhn8potRkz4HzV0t2
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=69665c73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JME-snQRKK3FB2Ujp74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyNCBTYWx0ZWRfX47K7/YGsUbVh
 Ab5ObSuAPYEaPlntiC3OFW0kh0AlPFeXC1O+TuOF3boylMKcIm64IBk4v4BBUiIppqG2AnRnh/M
 J24v2LpAIFR1GqYFSRfwsDhRDP1NBnWIaF3CVV0iiQXB19RpbijHjllglKg4+ZVErzixbI66nHA
 5Feib/tQj/DT6MAeJmubq99feqZorTOYqrmrMVjAkAsOIrr9Y4LOQghxLv0SHoENEH7xmLSR8f9
 /rg7MTERUwnvwtwAIA0IEv6/CdxT/gxi1NGPNjBlFs+gzT0+jzzOG/bmjBv/lNOwT2x13KYyY8u
 5gDyUQUj0rpShnPDCkzgCt+2kVITo83lFWCZ6INSL2E/wym7ILvgQAgv6PeKQq8Q8QanuZ8z5Ir
 BGnzVzZCweHB4CtJzknoS+7TW8qwqikQ8UyyOw0f4ad15BUnAIAIZAeOo1sCJeLCzwpkX7dRJAC
 rxpfSy4NP1WB/KlsL9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130124

Hi.

On 1/13/26 8:02 PM, Joel Fernandes wrote:
> 
> 

>>>>>>> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
>>>>>>>
>>>>>>> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.
>>>>>>>
>>>>>> IMO, we can increase that threshold. 512/1024 is not a problem at all.
>>>>>> But as Paul mentioned, we should consider scalability enhancement. From
>>>>>> the other hand it is also probably worth to get into the state when we
>>>>>> really see them :)
>>>>>
>>>>> Instead of pegging to number of CPUs, perhaps the optimization should be dynamic? That is, default to it unless synchronize_rcu load is high, default to the sr_normal wake-up optimization. Of course carefully considering all corner cases, adequate testing and all that ;-)
>>>>>
>>>> Honestly i do not see use cases when we are not up to speed to process
>>>> all callbacks in time keeping in mind that it is blocking context call.
>>>>
>>>> How many of them should be in flight(blocked contexts) to make it starve... :)
>>>> According to my last evaluation it was ~64K.
>>>>
>>>> Note i do not say that it should not be scaled.
>>>
>>> But you did not test that on large system with 1000s of CPUs right?
>>>
>> No, no. I do not have access to such systems.
>>
>>>
>>> So the options I see are: either default to always using the optimization,
>>> not just for less than 17 CPUs (what you are saying above). Or, do what I said
>>> above (safer for system with 1000s of CPUs and less risky).
>>>
>> You mean introduce threshold and count how many nodes are in queue?
> 
> Yes.
> 
>> To me it sounds not optimal and looks like a temporary solution.
> 
> Not more sub-optimal than the existing 16 CPU hard-coded solution I suppose.
> 
>>
>> Long term wise, it is better to split it, i mean to scale.
> 
> But the scalable solution is already there: the !synchronize_rcu_normal path,
> right? And splitting the list won't help this use case anyway.
> 
>>
>> Do you know who can test it on ~1000 CPUs system? So we have some figures.
> 
> I don't have such systems either. The most I can go is ~200+ CPUs. Perhaps the
> folks on this thread have such systems as they mentioned 1900+ CPU systems. They
> should be happy to test.
> 

Do you have a patch to try out? We can test it on these systems.


Note: Might take a while to test it, as those systems are bit tricky to
get.

>>
>> What i have is 256 CPUs system i can test on.
> Same boat. ;-)
> 
> thanks,
> 
>   - Joel
> 

