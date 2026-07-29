Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B4CA268;
	Wed, 29 Jul 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336859; cv=none; b=pGgsEm+xOrYakiHkmamGiVEkYm/SosFudfKHAQ+2RE0z8I4QPwV7lq9D1E/FudfBpxTWZQt88XjOJ21UhlYGTP9mtSWKJP80UPetQrtH21libt9KXUL3F7w796HOPheP2Zw6LvnN1VamRnwnPy556S7597SijVGT93DMlZMzvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336859; c=relaxed/simple;
	bh=cqbWrhOAt0P9vECJC0q//+b/D8YsbCKxPZ6CAHAKG6s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G5kGE0ImiUG7FbuagkZuaeGB/K+ZHD1hounDygYijf4I9sXd7aBLrtJpHSdUODgbJ14kQGbd3bqzXeDMyJ90jVsiAG0zxedwItE3FLwiV1HpKaCkDeOx1OhryGT5qg0Xaz7cC7SsJgPWV+bYz2pL2lglo/0J2MU59M8OUhUW+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trgy0w9f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trgy0w9f"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEmNlp213362;
	Wed, 29 Jul 2026 14:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V/5N4T
	lpiRbsq8FXi3DtU+q3gxjlGdBVulboxYjNUsg=; b=trgy0w9fD1G2yvxCIpOFXu
	PIevem7VGNXDeBw97W+V8Lu7hJTWzGoaV72TvkLZvaWnhehLeLOK4trJl2cYSvhp
	5CmpvpH2VT9DKaLpST0VPV/QNNkJbxbOdTtNtWwqgSNyn/mYIi3uyXqs8zFQFN/S
	isRETxcXwR/yhSUkOFWqLajXruSsMDcs+LnrDb4qsTnOdHPYzfkg6ZvfEW3Ln/c3
	S0f2RpUOtyNTtYCK6bWEGSVdfqXofJwzFEA/b991yDcI5qNb0VzaKcNR9wIh7twm
	7PxhnT2BGo6PvyOR5RyR6TLKcSZUIV5pbfHLas9F3Cs9vFQ+btnzxIdc3MpkhYgQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjaeqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:53:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEfKiG007381;
	Wed, 29 Jul 2026 14:53:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf24y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:53:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TErrWU35586306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:53:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9D7D20043;
	Wed, 29 Jul 2026 14:53:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3E7020040;
	Wed, 29 Jul 2026 14:53:49 +0000 (GMT)
Received: from [9.39.24.89] (unknown [9.39.24.89])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:53:49 +0000 (GMT)
Message-ID: <cda6b648-2c3a-4b01-8126-933056f221a9@linux.ibm.com>
Date: Wed, 29 Jul 2026 20:23:48 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
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
Content-Language: en-US
In-Reply-To: <e143d10e-69b1-455d-90b3-5f29a9482c15@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX7PwEIC5i/i1z
 tau3q7VkvAYih24i0EA6aDnpRlOb8/jI3SBTnuGxFjaGF2RS1ytT9kUahLrm1gY1hdoCoSkHLRr
 i3y3SBbYNX3BmkrGUVd4RXAWZIx6Vis=
X-Proofpoint-GUID: lvEVG1Lzb5arMdrFsSqlaDWambzl81vs
X-Proofpoint-ORIG-GUID: hSjyWncFqD0JwYfVNVkJ9lYIKGFQsoi5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX2Q7akR7p1J/I
 qkycJu36rGa03FjXPgVbvsR3/sca8OnR/d8z1ZdiYdAxYr55McDKOOqTlVE1R9bQQgqDffPHB3x
 HbhzBNJFffHEFPP3q1yBgmQanClIQFeeAMwOzszQgQVS8b/PDwYFnuhnLKInTc+nU3qllYuot4k
 McdhvUGX3BZ7VC0RQMpSlAXu2ut1qKMw+e26JA2CCNqYaUX28OMYz9QVPc7aJ2ZuPv6G4zfh7cl
 4ysuUE95xIOpgaJzqvwwc4u88BISCDIl/NmZjSO9AU6cyQpj/g6GXnr92wzkqEviuIvQGYKIrBZ
 K42GH9rKiNR/7kwXjPam8GQ+kkoJix0elv9y6GxBl0alVA0/43AXILL2TmLjNt54ViCe7oPSPsh
 HTriCSjTvvKuZ0QZCgA0i7twmkC6blKuS4oImaoWZM5ssrDzMoZZAYAIZCm1Shb//ZZzOs3PAtk
 6e7x1injOh+eKH2uYkw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a1407 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=0DI864wKsEq8_xCAzw8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290120



On 7/21/26 10:01 AM, Shrikanth Hegde wrote:
> 
> 
> On 6/16/26 11:39 AM, Shrikanth Hegde wrote:
>>
>>
> 
>>>>
>>>> On a large config system with 1920 CPUs, completion time improves from
>>>> ~1 hour to 5-6 minutes.
>>>>
>>>> Tested-by: Samir <samir@linux.ibm.com>
>>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>>
>>>  From an RCU viewpoint:
>>>
>>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> Thank you Paul for reviewing this.
>>
>>>
>>> I am guessing that you will be taking this up some other path, but if
>>> you would like it to to via RCU, please let me know.
>>>
>>>                             Thanx, Paul
>>>
>>
>> I would prefer this to go via tip tree since main change is in cpu.c
>>
>> Thomas, peter,
>> What do you guys suggest? can this go via tip tree?
>>
>> Also, do you have any other review comments on this or test to be done?
>>
> 
> Gentle Ping.
> 
> Thomas, Peter, Ingo, Can this go via tip tree?
> Do you guys have any comments to be addressed?
> 
> Or Do you want it to go via RCU tree?
> 

Gentle Reminder.

This might have fell through the cracks.
Are there any concerns still to be addressed?
