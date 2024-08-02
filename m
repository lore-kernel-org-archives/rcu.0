Received: from cloud48395.mywhc.ca (cloud48395.mywhc.ca [173.209.37.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD7175D20
	for <rcu@vger.kernel.org>; Fri,  2 Aug 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.209.37.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612991; cv=none; b=qtyA9w94L1NIv3nmSE7PmvIMcK6pWwsZwc2U3hel5bHmINqOfs3qcRMw70DEO44ZmnJE93IDqdU99gUpUHt8c0wT1UrTEOh/aXXHAn+1ivNyXJUMtP+WBcR8QKIqaZTXM9XJ4aW+hH1TaT178BAPuklowjhSzT5mYWC1ON+f4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612991; c=relaxed/simple;
	bh=4kmN0wscfUm2mX/7apTD9ppgahAP7gEIF9VpuqRMCdk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kH6jFyNiVXdcvaU8UngIBUKPHFjat701yNZhggSMmbkzpQY78yAwhAF1DMpjAv95RHiXL/e0tPWggGQVpQV9VZr23nwgieJyFWVDGCwThVDV8tFG+G6Prbw9HypFPb0N1Dvj/eHveW7vEJ89Kki38QiQQtXhUz0izweGSaIMa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com; spf=pass smtp.mailfrom=trillion01.com; arc=none smtp.client-ip=173.209.37.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trillion01.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trillion01.com
Received: from [45.44.224.220] (port=39636 helo=[192.168.1.177])
	by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <olivier@trillion01.com>)
	id 1sZuKM-0005Cd-32;
	Fri, 02 Aug 2024 11:36:22 -0400
Message-ID: <a38775aa4f97b50844e482ab05a51b13a8f11aa5.camel@trillion01.com>
Subject: Re: unexpected result with rcu_nocbs option
From: Olivier Langlois <olivier@trillion01.com>
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org
Date: Fri, 02 Aug 2024 11:36:22 -0400
In-Reply-To: <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
	 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
	 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
	 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
	 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
	 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
	 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
	 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
	 <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
	 <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
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

On Fri, 2024-08-02 at 06:58 -0700, Paul E. McKenney wrote:
> On Fri, Aug 02, 2024 at 09:46:03AM -0400, Olivier Langlois wrote:
> > On Thu, 2024-08-01 at 20:01 -0700, Paul E. McKenney wrote:
> > >=20
> > > Very good!!!
> > >=20
> > > The do_nocb_deferred_wakeup_timer() is due to call_rcu() being
> > > invoked
> > > in a context where it might not be safe to do a wakeup().=A0 RCU
> > > doesn't
> > > have a lot of choice in this situation, so the usual approach is
> > > to
> > > figure out what is invoking call_rcu() on your nohz_full CPUs and
> > > to
> > > make it run elsewhere.
> > >=20
> > > I don't know what is happening with mix_interrupt_randomness().
> > >=20
> > > 							Thanx,
> > > Paul
> > there few more that are popping out like:
> >=20
> > tsc_sync_check_timer_fn
> > mce_timer_fn
> >=20
> > but those 2 + do_nocb_deferred_wakeup_timer are not immediately
> > generating an interrupt. Only mix_interrupt_randomness does because
> > it
> > adds an already timed out timer. So the CPU is kicked on insertion.
> >=20
> > I have quickly looked at drivers/char/random.c
> >=20
> > and there is no obvious way to address this that I can think of
> > without
> > causing potential serious side-effects...
> >=20
> > but I really find mysterious that only 1 of my nohz_full cpus is
> > impacted this...
> >=20
> > and imho, this does not sound like a good idea to include interrupt
> > randomness of a nohz_full cpu...
> >=20
> > I think that I am going to throw down the towel of reaching the
> > goal of
> > 100% interrupt free for now. The amount of efforts required to
> > reach
> > the goal vs the diminishing result I can get is not a good deal.
> > For
> > now, I am going to tolerate this 27uSec interrupt once every 2-3
> > seconds...
> >=20
> > but I find this challenge very fascinating and I'll start to follow
> > Brendan Gregg's blog to learn more about the field.
> >=20
> > thank you very much for your assistance. I am leaving with an
> > impression that the rcu dev list is very helpful and friendly!
>=20
> Are you doing system calls on your worker CPUs?=A0 If so, one
> straightforward way to get rid of this is to make your application
> push
> the system calls off to the housekeeping CPU.=A0 Keep in mind that
> system
> calls often need to defer work of one sort or another.
>=20
> The real-time guys would know more about this sort of thing.
>=20
> 							Thanx, Paul
very little.

I signal pthread condition variable
that calls:

- gettid()
- futex()

and madvise(MADV_DONTNEED)
(I believe this comes from tcmalloc)

you are opening up my horizons and I think you are right. If the
nohz_full thread does not enter the kernel, it cannot interfere with
your nohz_full setup.

I need to take a break from this project to take care of other stuff
that I have neglected while being absorbed by this never-ending
challenge... but I'll definitely return to it with this new angle of
attack...

with the little amount of syscalls, it seems feasible to avoid them in
one way or the other.

at some point, it might be much easier to avoid the kernel than trying
to fight with it to do what you want it to do.

here is another sidenote. I am currently listening your talk about
NO_HZ_FULL and I enjoy it very much!

this made me realize that you were right about the odd detail that my
setup is having 4 rcuos... I do not understand neither why I end up
with 4. This is your mention in your talk about CONFIG_RCU_NOCB_CPU_ALL
(now CONFIG_RCU_NOCB_CPU_DEFAULT_ALL I believe). I thought that maybe,
I had this define set unknowingly... no I don't

/proc $ zcat config.gz | grep RCU
# RCU Subsystem
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU_GENERIC=3Dy
CONFIG_NEED_TASKS_RCU=3Dy
CONFIG_TASKS_RUDE_RCU=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_NOCB_CPU=3Dy
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem
CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
# RCU Debugging
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging
# CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set

boot params:
isolcpus=3D0,1,2 nohz_full=3D1,2 rcu_nocbs=3D1,2 rcutree.rcu_nocb_gp_stride=
=3D4
irqaffinity=3D3

dmesg output:
Aug 02 05:41:01 aws-dublin kernel: rcu: Hierarchical RCU
implementation.
Aug 02 05:41:01 aws-dublin kernel: rcu:         RCU restricting CPUs
from NR_CPUS=3D128 to nr_cpu_ids=3D4.
Aug 02 05:41:01 aws-dublin kernel: rcu: RCU calculated value of
scheduler-enlistment delay is 10 jiffies.
Aug 02 05:41:01 aws-dublin kernel: rcu: Adjusting geometry for
rcu_fanout_leaf=3D16, nr_cpu_ids=3D4
Aug 02 05:41:01 aws-dublin kernel: RCU Tasks Rude: Setting shift to 2
and lim to 1 rcu_task_cb_adjust=3D1.
Aug 02 05:41:01 aws-dublin kernel: RCU Tasks Trace: Setting shift to 2
and lim to 1 rcu_task_cb_adjust=3D1.
Aug 02 05:41:01 aws-dublin kernel: rcu:         Offload RCU callbacks
from CPUs: 1-2.
Aug 02 05:41:01 aws-dublin kernel: rcu: srcu_init: Setting srcu_struct
sizes based on contention.
Aug 02 05:41:01 aws-dublin kernel: rcu: Hierarchical SRCU
implementation.
Aug 02 05:41:01 aws-dublin kernel: rcu:         Max phase no-delay
instances is 1000.

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
     38     3 rcuos/2
     45     0 rcuos/3

yesterday, I did hypothesize that maybe my isolcpus setting could
explain why rcuos0 was present... but this cannot explain why rcuos/3
is there too!

this is strange...

