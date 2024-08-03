Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C857EEC3
	for <rcu@vger.kernel.org>; Sat,  3 Aug 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722725207; cv=none; b=jEur9t5o7PqIv8FN6Vh10UT9kF3+uSJSHmH5xUD5J4MMjD59j6lFKWpW51VKXr70aFifZ1KyL9E2KwxO+aURT/RNCThPx3jjw+iju/6TK9Z1zZbndWhrUsmDp0N7ys6dyL0466Wnss7oeZnAysv0cAF6qqKtMGnAUVdwUNZpwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722725207; c=relaxed/simple;
	bh=jzZQX0uzGE9cPi53jD4VBjFBZzgw21Ey7phf/+Kuy4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dgxXkQhg7O3wJ1w3JZol4r6czwohe32G4UIGCR6aM+S5bcz5DPJQYM0J5iAUdFUOSgg7DyOgJTf98HafwJPYMvKcJes8UDptV7mDvQt3JWgfLHmLpanTTdf0zVwWLd4W/eQedPzEBTJ/1J5GgmbB2G1znMTPWmYhIEOl3rVgpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=34888 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1saNWO-0008Pr-1d;
	Sat, 03 Aug 2024 18:46:44 -0400
Message-ID: <0378062f00156325f18fa683f5504772c4b4956f.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Sat, 03 Aug 2024 18:46:44 -0400
In-Reply-To: <2b9f8637-2d91-4981-980f-87e4aeb4c1b2@paulmck-laptop>
References: <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
	 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
	 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
	 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
	 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
	 <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
	 <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
	 <a38775aa4f97b50844e482ab05a51b13a8f11aa5.camel@trillion01.com>
	 <2b9f8637-2d91-4981-980f-87e4aeb4c1b2@paulmck-laptop>
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

On Fri, 2024-08-02 at 16:57 -0700, Paul E. McKenney wrote:
> > I signal pthread condition variable
> > that calls:
> >=20
> > - gettid()
> > - futex()
> >=20
> > and madvise(MADV_DONTNEED)
> > (I believe this comes from tcmalloc)
> >=20
> > you are opening up my horizons and I think you are right. If the
> > nohz_full thread does not enter the kernel, it cannot interfere
> > with
> > your nohz_full setup.
>=20
> Exactly!
>=20
> One approach is to have real-time threads used lockless shared-memory
> mechanism to communicate asynchronously with non-real-time threads.
> The Linux-kernel llist is one example of such a mechanism.
>=20
> Many projects do all their allocation during initialization, thus
> avoiding run-time issues from the memory allocator.=A0 Some use
> memlock()
> or memlockall() at initialization time to avoid page faults.
>=20

I want to bring this discussion to closure because I feel like I am
spamming your list with off topic stuff but my NOHZ_FULL issue has
experienced a happy ending so I wanted to share the outcome since you
have helped me a lot!

the mix_interrupt_randomness() was a symptom only. The only thing that
can make char device random mix interrupt randomness is if a processor
receives interrupts.

It turns out that some file i/o was initated without my awareness from
cpu0 or 1. I got a quick crash course from Jens Axboe about nvme device
driver anatomy. It creates 2 i/o requests queues and split the cpus in
2 balanced groups.

not sure exactly why irqs are still sent to different cpus since I
provide irqaffinity=3D3 in my boot params line but the solution has been
to hack the nvme driver code:

drivers/nvme/host/pci.c
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..70b7ca84ee21 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2299,7 +2299,7 @@ static unsigned int nvme_max_io_queues(struct
nvme_dev *dev)
         */
        if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
                return 1;
-       return num_possible_cpus() + dev->nr_write_queues + dev-
>nr_poll_queues;
+       return 1 + dev->nr_write_queues + dev->nr_poll_queues;
 }
=20
 static int nvme_setup_io_queues(struct nvme_dev *dev)

the end result is that my nvme device now only have 1 io queue managing
requests coming from all 4 cpus and the irqs are all sent to cpu3!

about eliminating syscalls, it will not be necessary but I am keeping
this new trick into my bag of tricks... I might need it sometime...

that being said, turning my attention to this has allowed me to realize
that I was using tcmalloc untweaked and I can squeeze much more
performance out of it with some minimal effort...

1. It use Transparent Huge Pages and recommends some system settings
for optimal performance that I have not set yet.
2. It offers a hook to offload memory housekeeping to a background
thread (including the madvise(MADV_DONTNEED) syscall I suppose).

this is clearly something that I will look into that I would not have
thought looking at without your suggestion!

all in all, it is an amazing experience to be a Linux Kernel user!

I now have practically 2 CPUs ot of 4 that runs at 100% with almost no
interrupts... this is a very cool and satisfying achievement!

If I stare long enough at 'watch -n1 cat /proc/interrupts'

I am seeing occasional CAL and TLB (TLB is a totally new concept to me)
CAL:       1726        803        784     300814   Function call
interrupts
TLB:         44          0         43          0   TLB shootdowns

something else to understand and master another day...

> > I need to take a break from this project to take care of other
> > stuff
> > that I have neglected while being absorbed by this never-ending
> > challenge... but I'll definitely return to it with this new angle
> > of
> > attack...
> >=20
> > with the little amount of syscalls, it seems feasible to avoid them
> > in
> > one way or the other.
> >=20
> > at some point, it might be much easier to avoid the kernel than
> > trying
> > to fight with it to do what you want it to do.
>=20
> These things go on a syscall-by-syscall basis, and much depends on
> your deadlines.=A0 For example, if you had one-millisecond deadlines,
> those 27-microsecond interrupts might not be a concern.=A0 ;-)

this is for a small crypto arbitrage trading client project of mine,
the trader that react the fastest wins... 27usec is a big deal. It is
the difference between winning or losing a trade

https://x.com/lano1106/status/1771345949320737183

