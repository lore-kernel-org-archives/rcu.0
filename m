Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A67148FFC
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540341; cv=none; b=QpbQI28uzQbNTcO8mLjfuwYJI5c0bd6Za2POW/6/lCKeMoCASpMYetzVBHo278lHL1X2aDbyXpn2xiOjvsrdmuI/VaQbeUwT4+yQ60YNCAbcBGrzUxHIVGRn8jQVotaOduKOFdvihssvEyPNl9ewohwgIZIo/4bHer1F86SHtLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540341; c=relaxed/simple;
	bh=L/hQx7+B5OppO9gQYEncr9c06jcDoogxQeGXX8cclU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIwg0pwkEY1zOPe1LMt9CveJQto/T5uiXC4WGDXX6E88nR/Ys/WcGcz9nL2s9ujpIh5ZGoXCMd2A3ooDnWPi2RiGMOrBi1cq3J6VpVHsjGpXG87zYHDFuAAJAwvUro/pkJWtv5kr1GmUQycUkL5hMc3JBTo9t4j+KrqNYc3BDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=50874 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sZbQg-0000nu-0S;
	Thu, 01 Aug 2024 15:25:38 -0400
Message-ID: <367dc07b740637f2ce0298c8f19f8aec0bdec123.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Thu, 01 Aug 2024 15:25:37 -0400
In-Reply-To: <fd5cedd3-d956-4a99-a50f-1fbc14fa208b@paulmck-laptop>
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
	 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
	 <fd5cedd3-d956-4a99-a50f-1fbc14fa208b@paulmck-laptop>
Autocrypt: addr=olivier@trillion01.com; prefer-encrypt=mutual;
 keydata=mQINBFYd0ycBEAC53xedP1NExPwtBnDkVuMZgRiLmWoQQ8U7vEwt6HVGSsMRHx9smD76i
 5rO/iCT6tDIpZoyJsTOh1h2NTn6ZkoFSn9lNOJksE77/n7HNaNxiBfvZHsuNuI53CkYFix9JhzP3t
 g5nV/401re30kRfA8OPivpnj6mZhU/9RTwjbVPPb8dPlm2gFLXwGPeDITgSRs+KJ0mM37fW8EatJs
 0a8J1Nk8wBvT7ce+S2lOrxDItra9pW3ukze7LMirwvdMRC5bdlw2Lz03b5NrOUq+Wxv7szn5Xr9f/
 HdaCH7baWNAO6H/O5LbJ3zndewokEmKk+oCIcXjaH0U6QK5gJoO+3Yt5dcTo92Vm3VMxzK2NPFXgp
 La7lR9Ei0hzQ0zptyFFyftt9uV71kMHldaQaSfUTsu9dJbnS2kI/j+F2S1q6dgKi3DEm0ZRGvjsSG
 rkgPJ5T16GI1cS2iQntawdr0A1vfXiB9xZ1SMGxL/l6js9BVlIx/CBGOJ4L190QmxJlcAZ2VnQzrl
 ramRUv01xb00IPJ5TBft5IJ+SY0FnY9pIERIl6w9khwLt/oGuKNmUHmzJGYoJHYfh72Mm8RQ1R/JS
 o6v85ULBGdEC3pQq1j//OPyH3egiXIwFq6BtULH5CvsxQkSqgj1MpjwfgVJ8VbjNwqwBXHjooEORj
 vFQqWQki6By3QARAQABtDJPbGl2aWVyIExhbmdsb2lzIChNeSBrZXkpIDxvbGl2aWVyQHRyaWxsaW
 9uMDEuY29tPokCNwQTAQgAIQUCVh3TJwIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBlaka
 GGsWHEI1AD/9sbj+vnFU29WemVqB4iW+9RrHIcbXI4Jg8WaffTQ8KvVeCJ4otzgVT2nHC2A82t4PF
 0tp21Ez17CKDNilMvOt8zq6ZHx36CPjoqUVjAdozOiBDpC4qB6ZKYn+gqSENO4hqmmaOW57wT9vII
 v6mtHmnFvgpOEJl6wbs8ArHDt0BLSjc8QQfvBhoKoWs+ijQTyvFGlQl0oWxEbUkR1J3gdft9Oj9xQ
 G4OFo73WaSEK/L9IalU2ulCBC+ucSP9McoDxy1i1u8HUDrV5wBY1zafc9zVBcMNH6+ZjxwQmZXqtz
 ATzB3RbSFHAdmvxl8q6MeS2yx7Atk0CXgW9z5k2KeuZhz5rVV5A+D19SSGzW11uYXsibZx/Wjr9xB
 KHB6U7qh5sRHaQS191NPonKcsXXAziR+vxwQTP7ZKfy+g5N/e6uivoUnQrl9uvUDDPXEpwVNSoVws
 Vn4tNyrGEdN11pHDbH5fSGzdpbY8+yczUoxMmsEQe/fpVwRBZUqafRn2TVUhV0qqzsUuQcTNw1zIZ
 JgvkqrHgd4ivd2b1bXBczmu/wMGpEnF6cWzSQDiwC1NF3i+gHCuD8IX1ujThWtzXsn0VtrMkrRCbn
 ponVQ6HcbRYYXPuK0HRRjCSuAKo5porVONepiOSmu0FBrpGqBkpBtLrzKXoi1yt/7a/wGdMcVhYGg
 vA==
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Thu, 2024-08-01 at 10:48 -0700, Paul E. McKenney wrote:
> >=20
> > yes I do.
> >=20
> > $ ps -eo pid,cpuid,comm | grep rcu
> > =A0=A0=A0=A0=A0 4=A0=A0=A0=A0 0 kworker/R-rcu_gp
> > =A0=A0=A0=A0=A0 8=A0=A0=A0=A0 0 kworker/0:0-rcu_gp
> > =A0=A0=A0=A0 14=A0=A0=A0=A0 0 rcu_tasks_rude_kthread
> > =A0=A0=A0=A0 15=A0=A0=A0=A0 0 rcu_tasks_trace_kthread
> > =A0=A0=A0=A0 17=A0=A0=A0=A0 3 rcu_sched
> > =A0=A0=A0=A0 18=A0=A0=A0=A0 3 rcuog/0
> > =A0=A0=A0=A0 19=A0=A0=A0=A0 0 rcuos/0
> > =A0=A0=A0=A0 20=A0=A0=A0=A0 0 rcu_exp_par_gp_kthread_worker/0
> > =A0=A0=A0=A0 21=A0=A0=A0=A0 3 rcu_exp_gp_kthread_worker
> > =A0=A0=A0=A0 31=A0=A0=A0=A0 3 rcuos/1
> > =A0=A0=A0=A0 38=A0=A0=A0=A0 3 rcuog/2
> > =A0=A0=A0=A0 39=A0=A0=A0=A0 3 rcuos/2
> > =A0=A0=A0=A0 46=A0=A0=A0=A0 0 rcuos/3
>=20
> This looks like you had either nohz_full=3D0-3 or rcu_nocbs=3D0-3, given
> that you have rcuos kthreads for all four of your CPUs.=A0 Or perhaps
> some
> other setting that implied one or the other of these.

the exact setting is:
isolcpus=3D0,1,2 nohz_full=3D1,2 rcu_nocbs=3D1,2 rcutree.rcu_nocb_gp_stride=
=3D4
irqaffinity=3D3

maybe you can quickly confirm this but by reading rcu/tree_nocb.h
but I have been under the impression that nohz_full=3D1,2 is implying
rcu_nocbs=3D1,2, therefore I could remove the rcu_nocbs parameter and it
would not change anything. (is there other ktread implications coming
along with isolcpus?).

I want to have control over what is run on cpu0 so it is enumerated in
isolcpus.

It is, however, not nohz_full. As I have mentionned in 1-2 emails ago.
cpu0 is where the networking I/O is made. net/core is such a big RCU
user + NIC driver interrupts (I am trying hard to eliminate them with
napi_busy_poll), that I have figured out making cpu0 nohz_full
efficiently was a lost battle before it even started.

maybe something somewhere is not used to see isolcpus and nohz_full
having different values and does something unexpected as a result...

>=20
> > > > > the absence of of rcuog/1 is causing rcu_irq_work_resched()
> > > > > to
> > > > > raise
> > > > > an
> > > > > interrupt every 2-3 seconds on cpu1.
> > >=20
> > > Did you build with CONFIG_LAZY_RCU=3Dy?
> >=20
> > no. I was not even aware that it was existing. I left alone the
> > default
> > setting!
>=20
> Worth a try, as this is what it is designed for.

Ok, I will but when I read what it is doing, I was under the impression
that the main objective was to trade low-latency with reduced power
consumption...

I am not seeing how batching callbacks would help in eliminating the
interrupts that I am seeing. At best, they will be less frequent...

and most importantly, I am going through all these loops to reduce my
system latency by few uSecs... power consumption is my last worry...

the only way that I would consider it, is if increasing RCU latency is
improving my program latency...

All options are considered... I will take a look at this suggestion.


