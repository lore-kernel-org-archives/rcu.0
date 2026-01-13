Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4F187346;
	Tue, 13 Jan 2026 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280105; cv=none; b=MON7A8r9Twxnv8ILe5ragsVZsuZtgaNkkISl70EzaxXWcvn7zVjS4fMzsHaRAKNmARSs4dGUOG0APjiSdy755bPBBkIxCn4VFpuva+6pRbWDwiMsUJEPl46FIIAyHUv3flafZZZhpoH4dac/mlj4CBQBw7X+GP8J8A/tWxBvu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280105; c=relaxed/simple;
	bh=FADupz6QFGS2jPmr/Vwq1l1zplIvTZ8gN9YpdvF0XYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OATCVR0ibfXVj6qIl79h5fTApkwEj6rCuuHr19Pc32yYrlaywoRWgmXmRIm15yuiPl+spfYwNxsj9UPdb9hJ7jsxwV/jwyBzjXqYwF9IS7dtTHpy4EzhGdzfhplGsu7vdPF3jv3I6o+x69iJCNcutqoojAFn9xheAMlXw41OqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lL1M2tAD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lL1M2tAD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D2MlJM025028;
	Tue, 13 Jan 2026 04:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UnAuMq
	0EhAguigX1vol5kg3mbB8ah8acER7K67kIpIc=; b=lL1M2tADC9Lb7SbepbhKpD
	siZUTSYqiMKtBvHijpFee8mdc93V5aidiRmzcy5QPwR7dQAsDwQbuZNavoqzg8ck
	xz3qobp8RN1vlVZovE6ZvjvB8tYmv+/YBWq+i1eOSKD5ZvQiOiFXPSDV6gUrn/53
	q6pVD3rKERuWSeAvEJ40rb3/qXfocDxSHD5hOxcHTLgnvjvu0SWsNdkJsgCszst4
	s9MXLjmKmF3WHiSFQS6cZEcROjWpNTiZnrNa2zDUtJfF0rN7sqOO86gUx3ZM72qD
	f6tt736bFnBkld1KXK/fQN8Dl1c2HT/zfWwbRJix4Q22vDs8Is8NcBDo/ywd1Erw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4aqub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 04:54:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60D4mGWL012621;
	Tue, 13 Jan 2026 04:54:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg4aqua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 04:54:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D2ZtkO025848;
	Tue, 13 Jan 2026 04:54:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kka6rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 04:54:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D4rvNW53739918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 04:53:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B50D620040;
	Tue, 13 Jan 2026 04:53:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E20620043;
	Tue, 13 Jan 2026 04:53:54 +0000 (GMT)
Received: from [9.124.220.174] (unknown [9.124.220.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 04:53:54 +0000 (GMT)
Message-ID: <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
Date: Tue, 13 Jan 2026 10:23:53 +0530
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
        Uladzislau Rezki <urezki@gmail.com>,
        "paulmck@kernel.org"
 <paulmck@kernel.org>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAzNyBTYWx0ZWRfX6NmJjtanzNII
 7AwApEk/geWKBXw3M+ft78UmUQoR1MxBeZTmmuLEVN6sJJlRwOsVECcsgU1qliUwPCCEOZfY3MK
 n1/tBdNxlZa7FlBsphIP8SSyxYvV/pBHaSh+flIXHTVnGpGp5A+zMvME6GExIwmmmQIg53N4fXL
 6+vUfg14g5RFEYqF+2eMzw/jLksefM2ihw2MZ4t6MVeN0Y7kWT1BO0Dtck32tb+FIu3SCrPcj9E
 6JDt1s2jWIy2rHwI8ei1wkw+2/ZdShXLduLeFvkW+oEeoCjdDdGKbGIjmpSHZ9dQmbKfVDyA8Eu
 bZCHr1eHtyAZNqsCqDYqGaFsJ7xzQs+kt/ZYYe6E+BDWy5jOh7MJ49xkhHo7Hz3qd6zZQvknSnm
 8h02qlYir4TY3J+uVpPLlnN/CifFObjjH9m05ssSGMF16T0usMMjafAmdF+M0ofy6nxmbMcXa84
 ahFp05jdQzd1UHvRxnQ==
X-Proofpoint-ORIG-GUID: pWloAc2dj1nwgTeg7E1O-3yUSnEGR4U7
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6965cfeb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=MMP32UuwVO6Ng30SYm4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AdNTT4QKSnUi_bAvwqNq0xgFPrjlpcW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601130037

Hi.

On 1/13/26 8:16 AM, Joel Fernandes wrote:
> 
> 


>>>>> Another way to make it in-kernel would be to make the RCU normal wake
>>>>> from GP optimization enabled for > 16 CPUs by default.>>
>>>>> I was considering this, but I did not bring it up because I did not
>>>>> know that there are large systems that might benefit from it until now.>
>>>> This would require increasing the scalability of this optimization,
>>>> right?  Or am I thinking of the wrong optimization?  ;-)
>>>>
>>> Yes I think you are considering the correct one, the concern you have is
>>> regarding large number of wake ups initiated from the GP thread, correct?
>>>
>>> I was suggesting on the thread, a more dynamic approach where using
>>> synchronize_rcu_normal() until it gets overloaded with requests. One approach
>>> might be to measure the length of the rcu_state.srs_next to detect an overload
>>> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
>>> lightly loaded conditions, default to synchronize_rcu_normal() without checking
>>> for the 16 CPU count.
>>>
>>> Thoughts?
>>
>> Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
>> unforgiving of pretty much any form of contention.
> 
> Makes sense. We could also just have a single list but a much smaller threshold for switching synchronize_rcu_normal off.
> 
> That would address the conveyor belt pattern Vishal expressed.
> 
> thanks,
> 
>   - Joel
> 

Wouldn't that make most of the sync_rcu calls on large system
with synchronize_rcu_normal off?

Whats the cost of doing this?

(Me not knowing much about rcu internals)
