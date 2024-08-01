Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A394143883
	for <rcu@vger.kernel.org>; Thu,  1 Aug 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538393; cv=none; b=ZkryCDBCKBPhwgG7Cz2O3JmC282t7zwTzpei29azyWnuEi5CeX3WXuA6gVI4D19gBn6Cmu9HXXe6BvIOe5aOrg3m160HfSGy4nkcCO877L2JrqqipCLJuhJi9T2HZ1kR3k396xvpbgJ3ePqoXoaKVWC+I1ru1MmAkC+sWh0UXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538393; c=relaxed/simple;
	bh=yYV/QnerrAwAIkteKQTy3rbdozx4ITXdrlyITvfyRRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nc0D+FYeRe6eadf0/58fo5kBKCywzUMhmgCgDKnq5las9rFmmrTo1yf9TB0DM4qLvVwH0l/opC8MlGymWyyYZrVRYiNO9tMvhQild3zAnduKO2ThnDuBnZHCXqswZR2ogKj/s2szCZQFyvykJVoYAUUFGdoiMnhikaZL2Y0waOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=49524 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sZavG-0007Dc-0v;
	Thu, 01 Aug 2024 14:53:10 -0400
Message-ID: <600f3c00593d7e67cd2ada9a2622da1548b9e695.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Thu, 01 Aug 2024 14:53:09 -0400
In-Reply-To: <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
	 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
	 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
	 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
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

On Thu, 2024-08-01 at 10:56 -0700, Paul E. McKenney wrote:
> This presentation might be helpful:
>=20
> 	https://www.youtube.com/watch?v=3D5yTf7u5J_kc
>=20
thx for the link. I will sure make time to watch it to improve my
understanding of RCU.

> > you didn't seem concerned that rcuog was missing for cpu1.
> > rcutree.rcu_nocb_gp_stride sets the group size (stride) and there
> > is 1
> > rcuog per group. I guess if I wanted to see a rcuog/1, I would need
> > to
> > set rcutree.rcu_nocb_gp_stride=3D1
>=20
> The grace-period functions of the lead rcuos kthreads have been
> pushed
> off into a smaller number of rcuog kthreads.=A0 Which is why you do not
> (repeat, *not*) have an rcuog kthread for each CPU.
>=20
> > it is probably not best possible setting but it is easy and simple
> > to
> > try out to see if it fix my problem.
>=20
> You probably do not want an rcuog kthread for each CPU, but it cannot
> hurt to try it.
>=20
> 							Thanx, Paul
so the og in the rcuog name means Offloading Grace-period?

just with this little exchange, there is a big layer of mystery that
got removed in my mind!

my big take-away of your last 2 emails, is that you do not think that
the interrupts that I am seeing are originating from RCU...

I'll try to figure out how with ftrace, bpftrace can track down the
interrupt origin...

possibly that there is a way to ask them to record the stack when a
specific function is called...

I will look into Brendan Gregg's blog for more ideas on how this can
done

but this is not something that I have never done before... I am
definitely outside my comfort zone in the last 7 days, it is very
challenging but at the same time very rewarding...

I did a quick search to who was calling irq_work_queue().

The call made by rcu_irq_work_resched(void) seemed to be so tailered to
my config settings and what I was seeing that I did assume that it was
the one but maybe not...

worse case scenario, I'll add a printk there to convince myself. Worse
case scenario, the trace will show up once ever 3 seconds.

