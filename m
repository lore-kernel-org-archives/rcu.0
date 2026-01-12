Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C43793B4;
	Mon, 12 Jan 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240879; cv=none; b=QhtjBlc709w2nwSUwFb7HTOWS+1przlSEKFIUidMBiD06HAlh44AMkRNOpYlM1vmV/xukcGpGkK9Yds1jspjlstDxIhZTzLaec4bCm3wCltZXyFyF1rkCQR54uPNYohcPa5iXeYtiDvSJLvpCoVz3vjOCyfya1HmZnLndxLIBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240879; c=relaxed/simple;
	bh=fVP0GxqfqeTJpU+SIp/bavNJBeOLJIQJ4r6XZ75szyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9NK6Iujkq2ZpDOhG6zGJ4zXjqa4pSgMH/qWLV6MTPG/J69ZLbj/YWbtt8XKV5J6P+2fNC/8T//fGp56vC8hGMuGpl+w49HUry30qFDuRIDYyNZVPPFFmeLZJBMOEmCZsjraR+z4zOYE8nauuEg25ZCuo2r4+JwbPNBEl16nyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZAMZPGSA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZAMZPGSA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7Kpag013676;
	Mon, 12 Jan 2026 18:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=urSy1g
	L/zHSEh1GKA9IKQ8m5jbLQMeBgpmKF66T49s8=; b=ZAMZPGSA0VbJFqglwH/uJA
	WySlAvPRo1r45LFVOhFxCAXYbfI8JC9LHKt3uFZE+Wu4aZ7Pc7q+L9ZG3H6pMt2C
	hjAb0fSdR2YR5tIl/s1+81DVWstnurY6b1u26lpczT+BrKMKyRuUabpdKSEff7FE
	P1ICbhOEHK8BN17NkA35/19vsIRz7TRucLsOGOtHye1DEl6pODpkr6Raa+48149l
	VfESLx//VHvsgh0SUIhnDyFgY8/mrCyu7Sa8P5GbzpaU1BhzYQeBjGTB3PZsZS3b
	g4ueiOUKfNp9X+m9e1EbZXt5/CP1LtlmJMc4DgGwNHViFHeo+egkoOVj0bXQS4Rw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsr4eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:01:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CI13bj019105;
	Mon, 12 Jan 2026 18:01:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsr4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:01:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CGiBRG025838;
	Mon, 12 Jan 2026 18:01:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk7dfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 18:01:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60CI0xjW52363630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 18:00:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12CFB2004D;
	Mon, 12 Jan 2026 18:00:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C81B20043;
	Mon, 12 Jan 2026 18:00:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.219.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Jan 2026 18:00:55 +0000 (GMT)
Date: Mon, 12 Jan 2026 23:30:52 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
        frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
        rostedt@goodmis.org, tglx@linutronix.de, sshegde@linux.ibm.com,
        srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <aWU21GJBx5WC0Gwv@linux.ibm.com>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <20260112142440.GN830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112142440.GN830755@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE0NyBTYWx0ZWRfX07u6aTbLgyHX
 QMoSyhf+ThTMv7Nb2QAJddW+K/i2OfSp/M2/d2z28wYTHBGWAFqh+QTTzCjvgA9I+S/Hj3GkV3+
 qQeo+/Rqs2KqV0p92XVLVe/LbPC8bYLNH18UW4O3n7NxYnActXyqU3NYZkzMgNHh3njP/K9EhwY
 tWzAAqZHdWFQHMEwcs6O0y7OgvIA7sqpoAuLTA14NenVgLM9udafJG0+VPZONjaqkNJFMjEF7yq
 jgLQFkegt/SBS7GXKDJBvu/p6D19eAw7Ix9dfmmXyXX6rqpNNAUXDPk/27ixHPtofVdL2oKH5K4
 rJtXT7Rgx1E1CD2GuKGDM7c9E/BYwAOgTZ6z+zpI17uDOszQQTTNpK1AXrOfn/DEs54MOtvFfup
 BOk81jOw5vYOX8LiGusd+NM7c4YkZGc7zyY7eexZ8kUy3NlTiD3OGM5/IjeopeLiIDEesucIpLQ
 n3JzpcXyud0NU92r/rw==
X-Proofpoint-GUID: ZPJhPHiQkyhVSKs59sUcKj1E0nps_jcI
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=696536e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AHx039Be-gzaUm18DmAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YRsmH3eoi7g55Frp2_RBWhVeRPOk4-iY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120147

Hello Peter,



On Mon, Jan 12, 2026 at 03:24:40PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> > Bulk CPU hotplug operations—such as switching SMT modes across all
> > cores—require hotplugging multiple CPUs in rapid succession. On large
> > systems, this process takes significant time, increasing as the number
> > of CPUs grows, leading to substantial delays on high-core-count
> > machines. Analysis [1] reveals that the majority of this time is spent
> > waiting for synchronize_rcu().
> > 
> > Expedite synchronize_rcu() during the hotplug path to accelerate the
> > operation. Since CPU hotplug is a user-initiated administrative task,
> > it should complete as quickly as possible.
> > 
> > Performance data on a PPC64 system with 400 CPUs:
> > 
> > + ppc64_cpu --smt=1 (SMT8 to SMT1)
> > Before: real 1m14.792s
> > After:  real 0m03.205s  # ~23x improvement
> > 
> > + ppc64_cpu --smt=8 (SMT1 to SMT8)
> > Before: real 2m27.695s
> > After:  real 0m02.510s  # ~58x improvement
> > 
> 
> But who cares? Its not like you'd *ever* do this, right?
Users dynamically adjust SMT modes to optimize performance of the
workload being run. And, yes it doesn't happen too often, but when it
does, on machines with (>= 1920 CPUs) it takes more than 20 mins to
finish.

- vishal
