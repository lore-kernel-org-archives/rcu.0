Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAB2D8DDF;
	Sat,  8 Aug 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179795; cv=none; b=h1gv1wVGuDski3R2KGy5f2HjCjoDt/Br4ogBF7aql/W6IkMjs45U5ICL4/xsC1GCChIc0+I/+ErKFBCxhDrMVeAiXoSPlUM86KGYNm+aPmjXudOu2yHV0t7oyC9CEaZb1CTGuzhr0of1C4Kpt48hwAcvyQPCAgD7rwFXsgnq1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179795; c=relaxed/simple;
	bh=SwX8g7PJXUEPc/oJyL2ckySFB25GjGxf43gHXxYM5KY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5bWoFWU3ufyg/VQsgEvFE61BnuLAHgWUZtdXl80cNYt0XuDoSEFakbg3RHfRuPeHMfwLeoELNXPVJVGCAEcmeCwI0j/QLjdH1BqEvEmM2e2gI8zKNNdg22dPBwei6UGQRsIjWs8ydpYpMWaHM1Ls6kl0mE4z++Rqlw6jNjX4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yh2wil3k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yh2wil3k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5m0BfXEdRXKbiEA2q/7frGCAqQfY5WWWRyO0Nfo0sGY=; b=Yh2wil3k7HTZp50n94NgTemhQ5
	Xe1FTzsmx9bGqIok6+le0LleujspXr2BrZgGbN6MnXNe2Bcg6XMXJvDz/CWKRqn2lE8JKmMSMo2xp
	jM2EKc4orBLuRPpyvGipeRZB7oMeckbVz7rTxuR2xFUqgsbvjy4prc6B2RUCVG6uiGwXtEnl9fMBX
	0aD9FUlX84uLgco3wm6f8AAnX+rm4aZWKUji8iqZT/DKGn6eNhMbfDpgN8Q2mAe8p6uL+39X+Su+e
	5HiK3uEl882IwpIiBpOEhPgG2PwqyxwJdfMvmbSBOv7mPDpnPRs5FnK+ohu4s3fLFj/kOMqQMtm4i
	BDgkSD+A==;
Received: from [2001:8b0:10b:5:3222:9b60:11f4:b82d] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsbCH-00000004aqn-3Z32;
	Sat, 08 Aug 2026 07:10:22 +0000
Message-ID: <4a8c82b27972f9dda156aede0fb352d58fa66db7.camel@infradead.org>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
From: David Woodhouse <dwmw2@infradead.org>
To: paulmck@kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>, 
	kvm@vger.kernel.org, rcu@vger.kernel.org
Date: Sat, 08 Aug 2026 08:09:52 +0100
In-Reply-To: <3da4c9d6-39ae-4cf4-8d79-9661968f7f7c@paulmck-laptop>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
	 <20260805195528.3853473-4-dwmw@amazon.co.uk>
	 <20260805203608.D3CA61F000E9@smtp.kernel.org> <anS8C4Cxqy6ehCo3@google.com>
	 <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
	 <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org>
	 <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
	 <9E3BF4F1-EB01-48DC-9DC3-6780EDE06CC2@infradead.org>
	 <3da4c9d6-39ae-4cf4-8d79-9661968f7f7c@paulmck-laptop>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-asZzyWpqlPHCKWPRMQBb"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-asZzyWpqlPHCKWPRMQBb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-07 at 14:55 -0700, Paul E. McKenney wrote:
> On Fri, Aug 07, 2026 at 12:02:57AM +0200, David Woodhouse wrote:
> > On 6 August 2026 23:52:06 CEST, "Paul E. McKenney" <paulmck@kernel.org>=
 wrote:
> > > On Thu, Aug 06, 2026 at 10:38:56PM +0200, David Woodhouse wrote:
> > > > On Thu, 2026-08-06 at 19:59 +0200, Woodhouse, David wrote:
> > > > > On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> > > > > > On Wed, Aug 05, 2026, sashiko-bot@kernel.org=C2=A0wrote:
> > > > > > > Replace the per-cache rwlock with RCU for the read side.
> > > > > >=20
> > > > > > I don't hate the idea, but I am very against using RCU.=C2=A0 U=
nless it's "impossible",
> > > > > > e.g. because synchronize_srcu() allocates memory and breaks OOM=
 kill, I would
> > > > > > strongly prefer to use SRCU, probably with a dedicated kvm->gpc=
_srcu, so that
> > > > > > synchronization doesn't need to wait on all CPUs in the system.=
=C2=A0 The tail latencies
> > > > > > for synchronize_rcu() are horrendous, especially for many-CPU s=
ystems.=C2=A0 If it
> > > > > > were only mmu_notifiers that got hit, it miiiight be acceptable=
, but since this
> > > > > > will affect vCPU tasks in the refresh() path as well, normal RC=
U is pretty much
> > > > > > a non-starter.
> > > > >=20
> > > > > Yeah, the refresh() path got pretty slow in my first attempt, bef=
ore
> > > > > optimising that *not* to have a grace period if the memslot gener=
ation
> > > > > changed but the actual GPA=E2=86=92uHVA (and memslot) don't *chan=
ge*.
> > > > >=20
> > > > > > Even SRCU could be problematic: if synchronize_srcu_expedited()=
 is forced to wait,
> > > > > > the wait time can easily get to 20+ milliseconds, which again i=
s a non-starter for
> > > > > > things like steal-time updates and nVMX pages.
> > > > >=20
> > > > > But we don't have to synchronize from the read side. The code pat=
h
> > > > > which will do so most often is gfn_to_pfn_cache_invalidate_start(=
). And
> > > > > the refresh() path which is already the fallback slow path which =
can
> > > > > sleep. Although in my tree I've optimised that *not* to incur a g=
race
> > > > > period when it's avoidable, as noted above.
> > > > >=20
> > > > > I'm more concerned by the fact that srcu_gp_end() might have to
> > > > > *allocate*, while the OOM reaper path waits for it. I'll see how =
we can
> > > > > deal with that...
> > > >=20
> > > > I think I need to invoke Paul et al for that one...
> > > >=20
> > > > Paul, Boqun, please could I trouble you to look at the top commit i=
n
> > > > https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=
=3Drefs/heads/xen-rcu-srcu
> > > >=20
> > > > The "gfn_to_pfn_cache" (GPC) here is for all extents and purposes a
> > > > TLB. It's caching the full two-stage translation through KVM memslo=
ts
> > > > which map a guest physical address to a userspace virtual address, =
and
> > > > then through the standard process page tables to a host physical
> > > > address.
> > > >=20
> > > > It is the second stage we are interested in here. Invalidation happ=
ens
> > > > through an MMU notifier, which (after I obey Sean's request to swit=
ch
> > > > to SRCU) calls synchronize_srcu_expedited().
> > > >=20
> > > > My problem:
> > > >=20
> > > > =C2=A01. The MMU notifier invalidation can be called from the OOM r=
eaper
> > > > =C2=A0=C2=A0=C2=A0 path. In this case it MUST NOT sleep to allocate=
 memory, or block
> > > > =C2=A0=C2=A0=C2=A0 on anything which does so. cf.
> > > > =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/all/787aa26cf62dfd361eea=
8ed19f384fc517892501.camel@infradead.org/
> > > >=20
> > > > =C2=A02. srcu_gp_end() does so, through init_srcu_struct_nodes(), w=
hile
> > > > =C2=A0=C2=A0=C2=A0 synchronize_srcu_expedited() effectively waits f=
or it =E2=80=94 precisely
> > > > =C2=A0=C2=A0=C2=A0 the thing we must not do. (Strictly, the waiter'=
s completion is
> > > > =C2=A0=C2=A0=C2=A0 queued to the same workqueue on which process_sr=
cu() could be
> > > > =C2=A0=C2=A0=C2=A0 blocked in init_srcu_struct_nodes(=E2=80=A6, GFP=
_KERNEL)).
> > > >=20
> > > > On a system with >=3D 128 CPUs it's actually OK because that alloca=
tion
> > > > path never happens; everything's allocated in advance ("rcu: srcu_i=
nit:
> > > > Setting srcu_struct sizes to big"). But on smaller systems I don't =
see
> > > > that we have a way to ensure that things are safe. (I don't count
> > > > setting big_cpu_lim to zero!)
> > > >=20
> > > > Could we change that init_srcu_struct_nodes(=E2=80=A6, GFP_KERNEL) =
to a non-
> > > > sleeping allocation? If the allocation fails, that isn't fatal, is =
it?
> > > > Or some other way to trigger the transition to big under controlled
> > > > circumstances in advance...?=20
> > >=20
> > > We could easily provide such an interface.=C2=A0 However, is there so=
me
> > > check that would allow us to determine when it is OK to use GFP_KERNE=
L?
> > > If there was, we could replace that GFP_KERNEL with something like th=
is:
> > >=20
> > > 	sleeping_alloc_ok() ? GFP_KERNEL : GPF_HEY_YOU_TELL_ME
> > >=20
> > > My best guess for GPF_HEY_YOU_TELL_ME is GFP_NOWAIT.
> > >=20
> > > That way, you don't need another SRCU API to transition to big, and
> > > everything "just works".
> > >=20
> > > What say you?
> >=20
> > Thanks for the prompt answer!
> >=20
> > It's a nice idea, but I'm not sure what we'd trigger on. In an
> > earlier patch in this same series I already ripped *out* the
> > non_block_start() for this OOM reaper path, because that would make
> > it sad even about the non-allocating sleep for the (S)RCU wait. The
> > actual criterion is more subtle than that.
>=20
> Yeah, you can be blocked waiting for memory "just because" from one
> call to synchronize_srcu() and then when you invoke synchronize_srcu()
> from the OOM reaper, you still block because your OOM-reaper-induced
> synchronize_srcu() can't start its grace period until the earlier
> synchronize_srcu()'s grace period completes.
>=20
> And there probably are a *lot* of similarly fatal scenarios.=C2=A0 :-/
>=20
> > And anyway, the allocation isn't even running from that thread;
> > it's on the workqueue.
>=20
> Maybe we need a GFP_SHORT_WAIT that gives up if more than (say) ten
> jiffies elapse.=C2=A0 Then the needed NULL return shows up and everything
> goes forward.=C2=A0 Plus if someone starts their first SRCU grace period =
from
> a safe MM state, it does what is needed to get the memory, thus reducing
> contention on the srcu_struct-related synchronization mechanisms.
> Which is why I am uncomfortable with unconditional use of GFP_NOWAIT
> or similar.
>=20
> What we have now is at best exceedingly non-ergonomic for the surprisingl=
y
> large fraction of the kernel that can be invoked from OOM/reclaim.
>=20
> > I think it has to be an API which lets us upgrade in advance. Or
> > just make it GFP_NOWAIT unconditionally? What's the failure mode if
> > the allocation fails? My unreliable AI friend told me it was
> > harmless enough... but I don't trust it much, which is why I
> > reached out to my meat friend...
>=20
> So your setup is has the default srcutree.convert_to_big=3D3
> (SRCU_SIZING_AUTO) and more than 128 CPUs, correct?=C2=A0 Does this need =
to
> work with old-school CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY,
> or is new-age CONFIG_PREEMPT_LAZY in place?

I'm trying to make this work for everyone. *My* setup doesn't have
PREEMPT_RT and I'm perfectly happy with the rwlocks, thank you very
much (well, I *was* until I saw how much better things scale when I
started experimenting with RCU...)

> Here are the options I can see at this point:
>=20
> 1.	As you and your AI friend suggest, change the GFP_KERNEL
> 	to GFP_NOWAIT.	As noted above, I am not so happy about the
> 	possibility of eternal contention due to eternal failure.

The only failure mode here is that it defers the upgrade to big mode,
and a few more grace periods run slightly less efficiency after the
threshold for upgrading has been tripped?

> 2.	As above, change the GFP_KERNEL to GFP_NOWAIT.	But then, upon
> 	failure, also invoke something in MM that greatly increases the
> 	probability of success on the next attempt.=C2=A0 I have no idea
> 	that that "something" might be.

I was pondering 'set a global flag to indicate that OOM is running' and
only using GFP_NOWAIT in that circumstance. That was icky enough in the
first place but I don't think it's viable anyway =E2=80=94 all SRCUs are
handled on the *same* workqueue, and that workqueue could already be
blocked on some *other* SRCU upgrading using GFP_KERNEL =E2=80=94 which cou=
ld
even have been the *reason* the OOM kicked in?=20

> 3.	Use a GFP_SOMETHING that can return NULL, but dynamically
> 	figures out how far it can go, possibly bounded by a timeout.
> 	Then we replace SRCU's GFP_KERNEL with that GFP_SOMETHING.
>=20
> 4.	Implement GFP_SOMETHING by hand by using GFP_NOWAIT, and on
> 	failure spawning a workqueue to do the allocation asynchronously
> 	in a clean environment, not blocking any grace period.
> 	This is complicated by the fact that it introduces concurrency
> 	into the allocation.

Is the concurrency so hard? The separate workqueue just needs to
allocate some memory, then WRITE_ONCE() the pointer to it. It can
actually be *consumed* by the next srcu_gp_end() run.

> 5.	Give you an init_srcu_struct_big() that is init_srcu_struct() if
> 	srcutree.convert_to_big is SRCU_SIZING_NONE or SRCU_SIZING_INIT,
> 	but immediately does the allocation otherwise.
>=20
> 	Of course, this allocation can fail, and if it does, you are
> 	right back where you started.

I think this doesn't work for much the same reason that #2 doesn't
work, since everything on the same workqueue so it would need to make
sure *nothing* takes the upgrade path; not just the SRCU in question?

> 6.	As above, but if the allocation does fail, do a self-propagating
> 	call_srcu() that keeps running until the allocation within
> 	srcu_gp_end() succeeds.=C2=A0 Something that I am sure that the
> 	battery-powered-embedded guys will just love.	And so will you
> 	if that from-OOM/reclaim call gets there before the successful
> 	allocation.=C2=A0 ;-)
>
> 7.	Combine #6 and #1, so that if init_srcu_struct_big() was used,
> 	srcu_gp_end() uses GFP_NOWAIT, but otherwise sticks with the
> 	current GFP_KERNEL.=C2=A0 This at least restricts the blast radius
> 	of GFP_NOWAIT fallout.

As I was reading through, I was landing on "combine #4 and #1": use
GFP_NOWAIT unconditionally, but on failure trigger a workqueue to
allocate that memory in a clean environment.

> I don't know about you, but none of these are sparking joy at this end.
> Other than the mythical GFP_SOMETHING, of course, but for that there is
> the small issue of it currently being mythical.
>=20
> If this must be fixed in SRCU, pragmatism says that I would hold my nose
> and take door #7.
>=20
> But first, is this *really* the best that we can do?

I'm more than happy to entertain a discussion about whether we should
be using RCU for this, and what type of RCU.

Trying to summarize where we're coming from... I described the GPC
already. We are currently using a rwlock, which is kind of OK (except
for the known scalability issues with rwlocks since even the reads have
to contend for a cache line). But it doesn't work on PREEMPT_RT because
in that setup, rwlocks become *sleeping* locks. As noted above, that
isn't *my* use case and it hasn't kept me awake at night and I largely
blamed it on RT for changing the semantics of a known lock type... but
I really ought to fix it.

We use the GPC read side from hardirq context and on the schedule_out
path, so sleeping locks are Right Out. And RT has no 'raw_rwlock_t'.

Now, *most* of our GPCs are basically per-CPU, so a plain spinlock
would mostly suffice. But the Xen shared_info and vcpu_info regions are
*not* per-CPU, and this directly affects the scalability of interrupt
delivery:
https://lore.kernel.org/all/8f41cb82b7c99d5a3d1dda016e4841326b4d8a52.camel@=
infradead.org/

I started experimenting with plain RCU, which is promising but Sean
pointed out that on a large hosting box with many pCPUs and lots of
small guests, each grace period is waiting for *all* of the host
CPUs... and directed me to SRCU:
https://lore.kernel.org/all/anS8C4Cxqy6ehCo3@google.com/

This *currently* seems like the best approach, if we can just work out
the wart of the OOM reaper thing. But I'm absolutely open to input.

--=-asZzyWpqlPHCKWPRMQBb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
jnDR1pM2yh3jF9alXbYdKgQAAAAAAAA=


--=-asZzyWpqlPHCKWPRMQBb--
