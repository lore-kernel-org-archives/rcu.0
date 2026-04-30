Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C193054C7;
	Thu, 30 Apr 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563418; cv=none; b=F4zKeICdQMER61ZTZVZUyasWUoiwU/0Hm9k6D1di5BAZYIlImZDlCfHbHjfWNMFoiCnfsu6V0Nm/AL8blnwmZFHQFYfeZq7t7XetbB4t2672V1VHpxBYJcxuXQqh8fIo0JI6PE60DWYZOQbXOY1l4ySZ7aIs/EaByULlZon3YJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563418; c=relaxed/simple;
	bh=uwhOux8oeNkoFiWEEbFxGjKgCIJKKUKBS1a+z02PWDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8bvgl0OoDO0MTYVhXXfMKehg30votZ6N8bZ7IRv5eYxGi6MSk+rXyvFSQWJS/VuUSY4hBCLP3s/pS3gW/IufLFon8n68O+PJO2rSDsSPdv+XtXJto7ZjB9klOGcM18B408G309Y6mA3AnAwc984PjUx8ydbHku1ljASDmu/434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uz/T6rwV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uz/T6rwV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UCP3Re036865;
	Thu, 30 Apr 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h9V1qH
	+yCoHPi85IK5Lz6IKOZqyxzFPjLfAxORR7lgk=; b=Uz/T6rwVbRIrMdQGt73sMb
	vwz0JyEk0EoocWwmx+AT21veamu2ieauvGOJADpOCK+fsev/rRYXLKCM60xDs1lj
	zIEk3DFr+dRWSii2wLE3lvqvGvnhQGrS7ngyqr8P/CUpq4i2qXBNnDSXnjBzApdA
	ldXPd/S6rei4moskoW7stD2zxGRqtOQI5KsRYGHPevdBg+bGa/qHcSaf0B2SUkye
	E0B/ixb6L1kxM/qfA0JiwqbQ8wTKP79XbhuzRpGALkYGKBpMDpO4JrxLF4Oxje8B
	V3HOR6ZSHurUrXFICunHctC6ZSKzi6NKRefif52nCUaT3NB7hYnVl9ZRJ7l8QZnw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e6u0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFOBqO025204;
	Thu, 30 Apr 2026 15:36:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqkrkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:36:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UFacTG32637596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 15:36:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2875058057;
	Thu, 30 Apr 2026 15:36:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8BBE5805D;
	Thu, 30 Apr 2026 15:36:34 +0000 (GMT)
Received: from [9.39.18.177] (unknown [9.39.18.177])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 15:36:34 +0000 (GMT)
Message-ID: <4597b29c-3548-482f-9a34-8d69a59d77fd@linux.ibm.com>
Date: Thu, 30 Apr 2026 21:06:32 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
To: paulmck@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Boqun Feng <boqun@kernel.org>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
 <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
 <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>
 <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Wmg3tAgrz8b2fQl0dwWKjuCWspfAAcQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfX+FH0OVqWT3um
 qS3uMtQnDCZz+jaMCAbaZgoUEJ14AZuBnF/tEdfLxq5+auzyaIkqcUIi2qZEnxP+qmB1sZb5tcO
 mzTmzRZWMCkKi3d+coeUV1xYJnlaOIg3n73znu1gDtA1DyDm0wt6f4A/vm+267gKTNFWJaQWwOK
 SYyzwkl5O6H3nXasOgzw4FuMrX55a3C2kJHaipgfNUzxZPRxNSggU/r0Q/jn7nAvLswPgs1fRMR
 RNNFqqHG1EdNsQboUijXjRQLWVSf7EX5SXynUeEMPA1PGtW1DGLCI7gZPJNwLByaZSMsfYM2iCn
 fBYqryW/qmAgMeHCXB+j29hGmJEVAAMi1hIdXvM/1faWiXy8thzEdMQ5C1Nw9X6WTvFRKFDQ2Go
 rRGkSUses5GxX18r2qobKjXGPfFTAILrik+kOYyI9f9lm7v5CNK3+p9Yggo7ub3jjyMfRLHmQTh
 UKFRXdVNvGPLzAeCrcg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f37707 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=VnNF1IyMAAAA:8 a=OO9Z8b08tAtk0z3vkt4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-GUID: yEsCtX3Np_yzCS6ZTvX-RMiNgwpiTZRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300158


On 30/04/26 8:30 pm, Paul E. McKenney wrote:
> On Thu, Apr 30, 2026 at 11:49:02AM +0530, Samir M wrote:
>> On 29/04/26 11:21 pm, Shrikanth Hegde wrote:
>>> Hi Samir.
>>>
>>> On 4/29/26 3:46 PM, Samir M wrote:
>>>> Hi Boqun,
>>>>
>>>> Thank you for pointing me to the existing patches. I have tested
>>>> both Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC
>>>> system (80 CPUs), and can confirm that the workqueue lockup issue is
>>>> not observed.
>>>>
>>> Can you try only paul's patch and confirm if the issue is fixed?
>>>
>> Hi Shrikanth,
>>
>> I have verified Paul’s “alone” patch, and it resolves the issue no workqueue
>> lockups are observed.
> Thank you, Samir!  May I add your Tested-by?
>
> 							Thanx, Paul

Hi Paul,

Yes, you may add:
Tested-by: Samir <samir@linux.ibm.com>

Thanks,
Samir
>> Regards,
>> Samir.
>>
>>
>>>> Test Environment:
>>>> - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online
>>>> and 384 possible CPUs)
>>>> - Kernel version: Latest upstream (7.1-rc1)
>>>>
>>>> Regression Testing Results:
>>>> All tests completed successfully with no issues observed:
>>>> - Hackbench
>>>> - Kernel selftests
>>>> - LTP scheduler tests
>>>>
>>>> The workqueue lockup that was previously occurring is no longer
>>>> present with the patches applied.
>>>>
>>>> References:
>>>> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-
>>>> d699ca496f83@paulmck-laptop/
>>>> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
>>>>
>>>> Best regards,
>>>> Samir
