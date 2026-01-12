Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E22773D3;
	Mon, 12 Jan 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214633; cv=none; b=W9VVjdk6KTDnyXDl1/9m75g8mhJp60vChImsENQ6nbSeqwGFfYSEu7trWL1yzYsb1d3kk6J7BepY9xX/ppfnydNCt6fua2nI0CrScety4AoxY2j+S/Tgo/lxhz/QMt4WDVFMTq6879Kj+W5hcBbIyjn5D2XY2H9gnMyhmUnDa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214633; c=relaxed/simple;
	bh=nJWP2xZ8cO6H1j/gW6UDIJtlOmsPkD9ksp4B4x7vjEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fb6iQbmU0K6lxg9AwZqijd/i5Ny1eqNCdDEs491w9UNU+1q/PjWKgywBdVS4qcSE1JX2Gjd2CKa3dplmV+SydtM6ovjK2L0jViCLJRRfACG120QS1venVjyiGbRfMj7vtBINxaHTibfJ5danevVxeHamHPv6g5Wi76F9lR9Z/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tMTvXMXi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tMTvXMXi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BBeeCI029311;
	Mon, 12 Jan 2026 10:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uMi4Wm
	D7qstMpOjw7dVRyv98Cqyi/dYTVI+DHbesTl4=; b=tMTvXMXiPX+oP0igD+5ugY
	QVC40mREXXHR02/uc1sIwa/4Q8rETxXDByq8See6t35y/vx5+sDcg68dbcqRiDxK
	gjgSA3/x4qmE9CNGnWiDoNtkiVFOVZpMLpVmol1j20SInBxbwfT6XBVgo6ReImQu
	HyKO3I8ax/dq8NNTFoY8jMaBppAV68MuuARJJRz2ifWA6VG/ccdkVWSiPePkCpEw
	RtlXlCQf1jjlHkNU6+w9dNBcIYhusYMx3nj7gDWKZQtqPsTGE89TPOWd6H1Q152l
	IOfpFim1XwNiw+yA9YVccP1oWIlhyfrEnAgj9dUkZzHMoRv66ep/7qoKlwuPdCvw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeppjww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 10:43:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CAgBr1019726;
	Mon, 12 Jan 2026 10:43:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeppjwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 10:43:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAChFt025552;
	Mon, 12 Jan 2026 10:43:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23mwd1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 10:43:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CAhW5X56295884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 10:43:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E3CF20043;
	Mon, 12 Jan 2026 10:43:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB94720040;
	Mon, 12 Jan 2026 10:43:27 +0000 (GMT)
Received: from [9.39.17.9] (unknown [9.39.17.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Jan 2026 10:43:27 +0000 (GMT)
Message-ID: <e6efda46-2f47-4a6e-8352-4794479e4a1f@linux.ibm.com>
Date: Mon, 12 Jan 2026 16:13:26 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
To: Uladzislau Rezki <urezki@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        tglx@linutronix.de, peterz@infradead.org, sshegde@linux.ibm.com,
        srikar@linux.ibm.com, aboorvad@linux.ibm.com
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <aWTIDGQ1_NYeO4iU@pc636>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=6964d05a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=A0Y-CKpzo18HiFePqPcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m0x9YtXBEyb4lRbYIAY8EgySoP54zzBL
X-Proofpoint-ORIG-GUID: 1SOZL7YqZRdHro_5ephMvGGHPczMAhry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX6tabbbvpaXsx
 YTOer3oLikHQRd4dT/War0IlN166qe4U1Gps29Xcv01P3G9oLySXL/oFvV/BFFzl79RN0KL5kqG
 zPN2ehq5JScAH2VEcV+0Gdi5VE8/tvSOaeUyQ2mD0K57h6k1qwcD6zqvHsuo2KF2k1YxvivW0Bz
 Y/BCgVxflVv2B/yUsmbvm826+mh19r8kF3yLOldjZbQxJI+Emlrjyx/dtQNq7GL6ZNAABT0IdPi
 A94FJ/QpZ8q2R4ZRpKF84Zkz99lmas8Rh+54BGg1NXd4Jl0fIJ6h7pdPgml/h61Cam2QFJa06L5
 Wy/dKeDswYIi61wvir3nhRES1I2yRrAQRfia8uXiYFgnfY3bESjYcWkmiciFbLYJymG88xBa5hy
 FtB4g3aqQn3O8VXXU++w2oyCERKE4pKuwV06m/Usaniie7qxQteFdzuzA9H4XTjGJ+3Y6e8Fm2c
 UDc6dF+dQlDvwOvFAPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081

Hi Uladzislau,

On 12/01/26 15:38, Uladzislau Rezki wrote:
> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
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

# echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp

After setting,

# time ppc64_cpu --smt=1;
real    1m10.726s          # Run 1
real    1m12.530s          # Run 2

# time ppc64_cpu --smt=8
real    0m36.661s          # Run 1
real    0m41.401s          # Run 2

Regards,
vishalc

