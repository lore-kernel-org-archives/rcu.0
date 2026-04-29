Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2D38BF8D;
	Wed, 29 Apr 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485095; cv=none; b=NJW58lh3bRllNSUToz3zA8NCuJ5CeVp4n8EBrLq7kahcamCK2EKhIXQT6vYRscD6bW9ghpjnwX+y5XxetNcboTfHOSdO07gsnqKxXM4wKIR+IIvcRzGtm16XL6aQlx2To0yGBTGXiO5hO9ZETnJ+RRw4tILoc76HQHy9/2Qqx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485095; c=relaxed/simple;
	bh=Fzh+ygiNw5Dhv/7LdkbkBtM1f6wsT7wB5Y0LTZVBB1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hczg8Y/alq96o6bU+peEucAEhuSQUmhogSt2MiNq7Aed960/vWsrFy955TRpyl0GtwzPYDHbzkfzK2xG9DpKjoQUsk7zmUqoWxXKz/HBNlY8iB4nE3FCisiumNiLzUF6MghK/3fTTgxp3/2pFp6SmLPFwT4FojLO2i72PXIn5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hoGL89hs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hoGL89hs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF1onn396004;
	Wed, 29 Apr 2026 17:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xYE3pt
	MboeKeZb2D5Qu/aBBO+kmVBbJdx8RwSOHXorM=; b=hoGL89hshOy7qu3tT9OXh2
	06sc13pw1ZmQwXJop/41DrHedPcRkOn87kgjep7/mYOBgo5E+tNrLNHSfp9FGfZR
	6CO0gfPVsR6wzvWoHFKlLzINi+ITevrGs55g3FAnByNipXppIuegdoUkSKkk1LGl
	oHXXT1nf2kp2eAdFv3fHTDJPyermWXDpPcDBQnsaDNaXTPgvWiKfYz5iVsOsiavC
	su5lNMEAuoLCvoQ1yECofpr7E/MgQOw3nyPho1gzkzm77mym3XWNGhT2cXGy+K72
	caEaXmemUo3MOXRRYtNSYjkOXMpgvLbsFkipvPVas/rMFU2kA8URkwEwsPRLNViQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vjbhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:51:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63THd1Rx020550;
	Wed, 29 Apr 2026 17:51:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyf61k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:51:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63THpNCH56164654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:51:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA2120043;
	Wed, 29 Apr 2026 17:51:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7851720040;
	Wed, 29 Apr 2026 17:51:20 +0000 (GMT)
Received: from [9.124.221.220] (unknown [9.124.221.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 17:51:20 +0000 (GMT)
Message-ID: <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
Date: Wed, 29 Apr 2026 23:21:19 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
To: Samir M <samir@linux.ibm.com>, "Paul E . McKenney" <paulmck@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Boqun Feng <boqun@kernel.org>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f2451e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=SltLtrhv4OmeOPo6kIgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-ORIG-GUID: _sOAm_Wn_KlF51Dlhb5XpF1pXgwTbLan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3OSBTYWx0ZWRfX2zilRbQWtkR8
 v3KGwBmpl5pBm77d04qsz0DkmjiKJ0Up26LcB/jhjsWr1t0KxA/bXM/X3zBkprgivvo8jAZnhUZ
 P704EBAIZn379VChyaZpLPCKe4d1KBdpXkCiuEd5knjdpZr+wSF9ewlCs+BhP/TDakDgaaPvpm/
 vnAaPhkIgr4Bb6o/HuV2dENP/R45hNtCAVOmJQr7k8cBoKeIkazk65LobbTU6R6ozPc5MjLmcKs
 Z1GxBEWMLSaO3D7Z9+obgwRaJvu1qrErLFFZ2PWy4EcasKfHEwiD6gNMEuY4OdGxiDURSpdf1VL
 xpu6x5QVAT0M0+VxWaHNS+Q8I9CU3oKyOjYBB6VQuWVU/ZSgGG8hEUq8Z3XKDmm3jC+FcnFrfyI
 s4p+4ARb95f3bRW/5H+J3YqMZvsDp80C0GJYtZQRafYVd9rJA37OMoT7+ZzJwE3fbhH210ZLWU4
 r9Xf6/7EZGcVtuT1HdA==
X-Proofpoint-GUID: vXQyVNRMRfTYp_w2LZbMfCxWk6vLQHUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290179

Hi Samir.

On 4/29/26 3:46 PM, Samir M wrote:
> 
> Hi Boqun,
> 
> Thank you for pointing me to the existing patches. I have tested both 
> Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC system (80 
> CPUs), and can confirm that the workqueue lockup issue is not observed.
> 

Can you try only paul's patch and confirm if the issue is fixed?

> Test Environment:
> - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online and 
> 384 possible CPUs)
> - Kernel version: Latest upstream (7.1-rc1)
> 
> Regression Testing Results:
> All tests completed successfully with no issues observed:
> - Hackbench
> - Kernel selftests
> - LTP scheduler tests
> 
> The workqueue lockup that was previously occurring is no longer present 
> with the patches applied.
> 
> References:
> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d- 
> d699ca496f83@paulmck-laptop/
> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
> 
> Best regards,
> Samir

