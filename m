Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1E1B9B31
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533678; cv=none; b=MzeQkW+62eExGKGX+ESK4h429nPY7pLPCsOW2sLh1ppILFsX863iW75mHm99FUqiJKx1rk1XvBHjq2sk2Slp9dXcTiwQ6Y3NO3yZaAykcx34Z00x2gfuUfHwRWox1ENz86taxSAJ77UdVRTo09z37DHPuHFBOzqxRljxaqris10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533678; c=relaxed/simple;
	bh=Sj0zlgGjf8YjXROQAsU2gAr0wcG1U0lP+fpjzI74ITQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdB9IaeSfD+MrJ5kTGFhQJWv8YDbkVI7uk8B/HYPKgg9fyCr5k0O9G4EHMtV4YzTy4y5zo3PAdB+AjjldLOg5Y5nujPaWuY6bNtFm4UCKX8pG2xb8hXqmQEvQtZeMwdlMAFOsayGKlhzuAiIfvmKzTkjbIwG7apiT+F9hUhiaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=43404 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sZZh0-0002Ng-2v;
	Thu, 01 Aug 2024 13:34:22 -0400
Message-ID: <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Thu, 01 Aug 2024 13:34:21 -0400
In-Reply-To: <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
	 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
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

On Thu, 2024-08-01 at 12:32 -0400, Olivier Langlois wrote:
> >=20
> > This is the kthread that invokes the callbacks for CPU 1, assuming
> > you
> > have a non-preemptible kernel (otherwise rcuop/1 for historical
> > reasons
> > that seemed like a good idea at the time).=A0 Do you also have an
> > rcuos/2?
> > (See the help text for CONFIG_RCU_NOCB_CPU.)
>=20
> yes I do.
>=20
> $ ps -eo pid,cpuid,comm | grep rcu
> =A0=A0=A0=A0=A0 4=A0=A0=A0=A0 0 kworker/R-rcu_gp
> =A0=A0=A0=A0=A0 8=A0=A0=A0=A0 0 kworker/0:0-rcu_gp
> =A0=A0=A0=A0 14=A0=A0=A0=A0 0 rcu_tasks_rude_kthread
> =A0=A0=A0=A0 15=A0=A0=A0=A0 0 rcu_tasks_trace_kthread
> =A0=A0=A0=A0 17=A0=A0=A0=A0 3 rcu_sched
> =A0=A0=A0=A0 18=A0=A0=A0=A0 3 rcuog/0
> =A0=A0=A0=A0 19=A0=A0=A0=A0 0 rcuos/0
> =A0=A0=A0=A0 20=A0=A0=A0=A0 0 rcu_exp_par_gp_kthread_worker/0
> =A0=A0=A0=A0 21=A0=A0=A0=A0 3 rcu_exp_gp_kthread_worker
> =A0=A0=A0=A0 31=A0=A0=A0=A0 3 rcuos/1
> =A0=A0=A0=A0 38=A0=A0=A0=A0 3 rcuog/2
> =A0=A0=A0=A0 39=A0=A0=A0=A0 3 rcuos/2
> =A0=A0=A0=A0 46=A0=A0=A0=A0 0 rcuos/3
>=20
> and yes my kernel is built without CONFIG_PREEMPT. Since my system
> consists of 3 isolated cpus out of 4, I have figured that there was
> not
> much to preempt for the overhead coming along with the feature.
>=20
> but here again, I am thankful for the cue... If all else fail,
> running
> the setup with CONFIG_PREEMPT enabled to see if it change anything,
> this might be something interesting to try.

I have just set rcutree.rcu_nocb_gp_stride=3D4.

$ ps -eo pid,cpuid,comm | grep rcu
      4     0 kworker/R-rcu_gp
      8     0 kworker/0:0-rcu_gp
     14     0 rcu_tasks_rude_kthread
     15     0 rcu_tasks_trace_kthread
     17     3 rcu_sched
     18     3 rcuog/0
     19     0 rcuos/0
     20     0 rcu_exp_par_gp_kthread_worker/0
     21     3 rcu_exp_gp_kthread_worker
     31     3 rcuos/1
     38     0 rcuos/2
     45     0 rcuos/3

this different setting did not eliminate the sporadic IWI and LOC
interrupts on CPU1

I think that I have misunderstood the explanation about the RCU kthread
groups. I thought that this setting would add a rcuog process for CPU1.

you didn't seem concerned that rcuog was missing for cpu1.
rcutree.rcu_nocb_gp_stride sets the group size (stride) and there is 1
rcuog per group. I guess if I wanted to see a rcuog/1, I would need to
set rcutree.rcu_nocb_gp_stride=3D1

it is probably not best possible setting but it is easy and simple to
try out to see if it fix my problem.

