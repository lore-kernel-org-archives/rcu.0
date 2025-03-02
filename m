Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D424C85;
	Sun,  2 Mar 2025 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941196; cv=none; b=uuQx1I5L0nDDv8Epp93dLa5z2EoPRxsNo01qooyh94Plgd5RGCmrwH7pGvw3qRY4pQp6HWfvfldiV3Z3TNwPLqynYkcH5U03lqxUzOisaFvaGmzhzbD78rb+4boo9yRiZ0NwvqjjNaEoHdy30+i+bh2Z0zFwUiK66q6831Kaw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941196; c=relaxed/simple;
	bh=WOFOLeUbVmXSdUxdlaJsXhhdBxWzLTmDdzdq21IqplY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUnaK6QkxVNS/7vPpKHGvOGY1g4W15ndGcVwBrAD0hMi4dIQEHQBaNMjJKUBRILCg5fvjsOe2fzs1gkgDkzRXpeXz+tIag5QsBvytK3e3aQEx0zgAQYbvjdhv3P2cCZfSZCguQ0EaBJM57kB7sfKmwUzg8mLKbKy6EEzbfQjbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZY0JMiq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZY0JMiq"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ab9ea2deso10500096d6.3;
        Sun, 02 Mar 2025 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740941193; x=1741545993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WzQ+12QDyRdLjQO25TxuFUD3CrjOwGZzwL0CIxASzj0=;
        b=EZY0JMiqnm2WcxmYVjbq08IPrOGH2t//HEFhP19+KvlpeVD69BduztE+tdnDEAY2qm
         ctC70ZmKzftLbacor0gg3YO0+/vwFShIFj3JumW+nqABHxrSoO31IiFL1Sn4aXBJ8RRt
         VEFRZG624kBBU1uOfZidNM55m+kbRJgmrZxRWXvAK92lrPmG0XAEyRiRrJ0nri8e+ELl
         mEJPQ4c6/DBXTiZdntQHXZX3OgzLvd0ax9fI567QypaMS6Ss3uSrHMtOCnQWztvtHI25
         h4f88gGT6+nS6RMdVPaiPXGsnQJt2AATzqyEkbK2eKts343OcnNFnoHIXWUOMjetOLs8
         6QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740941193; x=1741545993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzQ+12QDyRdLjQO25TxuFUD3CrjOwGZzwL0CIxASzj0=;
        b=gpXiCNg+/HAap/utnlkvgmw5aIG1vZPARyPt31+9H9GLBU8/GZ0+UWVMl6Hxl/ijLQ
         Oxx/HEIf+xZ1Q5IHr9vqaVTbtadhF3+yYeAYPL/freKKL+BX21/ygrL5e7bmtZDFNWs1
         6ur9Dc1DWEtItK46CzcUHrAqhqlvYc5o9TRwa3nn0ApaZ9ehMNNWgOFr2YueqOU2HTSZ
         Fnbs9kS9RoqXRdbov0vsHimWevupkXcxXyfP5Oacobnzk6gzXWoCwgNWYPG39y0xqec2
         L+7CN9XMuv9ku4rRy29sFZEP5TstONU8klws5OXJcVSJ619HNeNHy7VlCwbq9oRaCgrN
         cEqA==
X-Forwarded-Encrypted: i=1; AJvYcCXb2VAilZ9GvTV6ETyP13TwMv9o/piGi7zxUDsdbVICgEurKdQ0u70nDRCFEmKrgvnMaJrO@vger.kernel.org, AJvYcCXgBhEyWWa9RUqtveOoR1Y1v08EjHZcTIzlajcaA05B/pY1+pE5XF2BQFvQl98pXyeQamdktpQasyk3MFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWLpkBknwmmUEng5dlTFVzEePSepEPiluRh/hp/AT6RtbOetF
	34BpZZUWI6t+NuSJhRGaSdr7EFDIjXdnThcbr764rUbNtHmNKhdk
X-Gm-Gg: ASbGnctuESczRfyLjdmRUGiSOYsdN6CPrGkVJOoFnyP18x0mqSluHLdRNV8qFYW4iQz
	VdYMAogubOvP7bX8CIJpuJvV5hXB+oZCyi1lpXZYMyxf/bro0YKN3nC5tjGEhwDmIbIgULJ7Qsl
	CYcMWfFRxfXeVgQsp8l8K8DWgFq0VWguzRKv0Rk5NgN4wLMTeCChwQXsi0A2DxyEPMpUnvB7im6
	s5tbV5bx7PrTjqPfpTEJg4Wm/Tt3LNuAnVR0dm+QMVF+vI/CrX/k/XDDZM5Z3ijBcdsl+Gbj5KI
	/StOWSQjWYsIDktU3UF7G6B+XDpap9VDXGTmKprFlNUP0fsLuPwA5JjR7nbDzqWT3Gfjy0ZFKEY
	AuPvIVNWGiDXuqa57v1dfx9G5dakZvJ/RoK8=
X-Google-Smtp-Source: AGHT+IHFc+k6NERTTpZC8kFHye3hXrXZsipWlJFFWusLd12IagaAKMpGGpHwNKi4H1m7CITzT5RzKA==
X-Received: by 2002:ad4:4eeb:0:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6e8a0cce81amr174138036d6.2.1740941193330;
        Sun, 02 Mar 2025 10:46:33 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765378esm44569026d6.48.2025.03.02.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:46:32 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C34A1200043;
	Sun,  2 Mar 2025 13:46:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 02 Mar 2025 13:46:32 -0500
X-ME-Sender: <xms:iKfEZ2kp1InUQ46WhyXOcD48S1u7qN0CL5Za-z75YW2ypKtbco-_vA>
    <xme:iKfEZ90TTM-QxmhMTpV9-ZMp8aHgmIf2oBrlfiR0FnD1OVLE71zVjwlQ3ZVA6q4NH
    VpVU5sIgnhj2srw4Q>
X-ME-Received: <xmr:iKfEZ0pbWYr1ITn22KYSHUpeGiRV7PIRZeBFERuXBAhjeT-ZB9rtDU_sAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeftddvgfduffdtffefjedvgedtvddvhfek
    udfggeekfedtffeltdeutefgveekteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhrvgiikhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepiiiiqhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgv
    vghrrghjrdhuphgrughhhigrhiesrghmugdrtghomhdprhgtphhtthhopehjohgvlhesjh
    hovghlfhgvrhhnrghnuggvshdrohhrghdprhgtphhtthhopeholhgvkhhsihihrdgrvhhr
    rghmtghhvghnkhhosehsohhnhidrtghomh
X-ME-Proxy: <xmx:iKfEZ6nGK8nqdyBanKCyEiyZgBdLnAv6e3_UBv4JjXOI5-A2ymBysw>
    <xmx:iKfEZ00wL-rBZsXbehYk80SxoiG_zVaoif_RJuRstZFzh-4QQGL03Q>
    <xmx:iKfEZxtbX-mbqmOocAJJrCEABwjCPjPUd-CnH7858Qau4QRQMreqQw>
    <xmx:iKfEZwWe9eIh3GX9Q_vk53ZoGEAGOaMgIGQUzc9cVNi0dC4fG1QEEw>
    <xmx:iKfEZ_2S2Vmd1EGocN0FYRsK9jvUgNULpN5nGNZen7TxCwIASBooScT9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Mar 2025 13:46:31 -0500 (EST)
Date: Sun, 2 Mar 2025 10:46:29 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8SnhS_LnzN_wvxr@tardis>
References: <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
 <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <Z8QwwBCoWb4J3_Xv@pc636>
 <d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop>

On Sun, Mar 02, 2025 at 09:39:44AM -0800, Paul E. McKenney wrote:
> On Sun, Mar 02, 2025 at 11:19:44AM +0100, Uladzislau Rezki wrote:
> > On Fri, Feb 28, 2025 at 05:08:49PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 28, 2025 at 11:59:55AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 28, 2025 at 08:12:51PM +0100, Uladzislau Rezki wrote:
> > > > > Hello, Paul!
> > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Except that I got this from overnight testing of rcu/de=
v on the shared
> > > > > > > > > > RCU tree:
> > > > > > > > > >=20
> > > > > > > > > > WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_s=
r_normal_complete+0x5c/0x80
> > > > > > > > > >=20
> > > > > > > > > > I see this only on TREE05.  Which should not be too sur=
prising, given
> > > > > > > > > > that this is the scenario that tests it.  It happened w=
ithin five minutes
> > > > > > > > > > on all 14 of the TREE05 runs.
> > > > > > > > > >=20
> > > > > > > > > Hm.. This is not fun. I tested this on my system and i di=
d not manage to
> > > > > > > > > trigger this whereas you do. Something is wrong.
> > > > > > > >=20
> > > > > > > > If you have a debug patch, I would be happy to give it a go.
> > > > > > > >=20
> > > > > > > I can trigger it. But.
> > > > > > >=20
> > > > > > > Some background. I tested those patches during many hours on =
the stable
> > > > > > > kernel which is 6.13. On that kernel i was not able to trigge=
r it. Running
> > > > > > > the rcutorture on the our shared "dev" tree, which i did now,=
 triggers this
> > > > > > > right away.
> > > > > >=20
> > > > > > Bisection?  (Hey, you knew that was coming!)
> > > > > >=20
> > > > > Looks like this: rcu: Fix get_state_synchronize_rcu_full() GP-sta=
rt detection
> > > > >=20
> > > > > After revert in the dev, rcutorture passes TREE05, 16 instances.
> > > >=20
> > > > Huh.  We sure don't get to revert that one...
> > > >=20
> > > > Do we have a problem with the ordering in rcu_gp_init() between the=
 calls
> > > > to rcu_seq_start() and portions of rcu_sr_normal_gp_init()?  For ex=
ample,
> > > > do we need to capture the relevant portion of the list before the c=
all
> > > > to rcu_seq_start(), and do the grace-period-start work afterwards?
> > >=20
> > > I tried moving the call to rcu_sr_normal_gp_init() before the call to
> > > rcu_seq_start() and got no failures in a one-hour run of 200*TREE05.
> > > Which does not necessarily mean that this is the correct fix, but I
> > > figured that it might at least provide food for thought.
> > >=20
> > > 							Thanx, Paul
> > >=20
> > > ---------------------------------------------------------------------=
---
> > >=20
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 48384fa2eaeb8..d3efeff7740e7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1819,10 +1819,10 @@ static noinline_for_stack bool rcu_gp_init(vo=
id)
> > > =20
> > >  	/* Advance to a new grace period and initialize state. */
> > >  	record_gp_stall_check_time();
> > > +	start_new_poll =3D rcu_sr_normal_gp_init();
> > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > >  	rcu_seq_start(&rcu_state.gp_seq);
> > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > -	start_new_poll =3D rcu_sr_normal_gp_init();
> > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start=
"));
> > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > >
> > Running this 24 hours already. TREE05 * 16 scenario. I do not see any
> > warnings yet. There is a race, indeed. The gp_seq is moved forward,
> > wheres clients can still come until rcu_sr_normal_gp_init() places a
> > dummy-wait-head for this GP.
> >=20
> > Thank you for testing Paul and looking to this :)
>=20
> Very good!  This is a bug in this commit of mine:
>=20
> 012f47f0f806 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detecti=
on")
>=20
> Boqun, could you please fold this into that commit with something like
> this added to the commit log just before the paragraph starting with
> "Although this fixes 91a967fd6934"?
>=20
> 	However, simply changing get_state_synchronize_rcu_full() function
> 	to use rcu_state.gp_seq instead of the root rcu_node structure's
> 	->gp_seq field results in a theoretical bug in kernels booted
> 	with rcutree.rcu_normal_wake_from_gp=3D1 due to the following
> 	sequence of events:
>=20
> 	o	The rcu_gp_init() function invokes rcu_seq_start()
> 		to officially start a new grace period.
>=20
> 	o	A new RCU reader begins, referencing X from some
> 		RCU-protected list.  The new grace period is not
> 		obligated to wait for this reader.
>=20
> 	o	An updater removes X, then calls synchronize_rcu(),
> 		which queues a wait element.
>=20
> 	o	The grace period ends, awakening the updater, which
> 		frees X while the reader is still referencing it.
>=20
> 	The reason that this is theoretical is that although the
> 	grace period has officially started, none of the CPUs are
> 	officially aware of this, and thus will have to assume that
> 	the RCU reader pre-dated the start of the grace period.
>=20
> 	Except for kernels built with CONFIG_PROVE_RCU=3Dy, which use the
> 	polled grace-period APIs, which can and do complain bitterly when
> 	this sequence of events occurs.  Not only that, there might be
> 	some future RCU grace-period mechanism that pulls this sequence
> 	of events from theory into practice.  This commit therefore
> 	also pulls the call to rcu_sr_normal_gp_init() to precede that
> 	to rcu_seq_start().
>=20
> I will let you guys decide whether the call to rcu_sr_normal_gp_init()
> needs a comment, and, if so, what that comment should say.  ;-)
>=20

Please see the updated patch below (next and rcu/dev branches are
updated too). For the comment, I think we can add something like

	/*=20
	 * A new wait segment must be started before gp_seq advanced, so
	 * that previous gp waiters won't observe the new gp_seq.
	 */

but I will let Ulad to decide ;-)

Regards,
Boqun

------------------------>8
Subject: [PATCH] rcu: Fix get_state_synchronize_rcu_full() GP-start detecti=
on

The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
functions use the root rcu_node structure's ->gp_seq field to detect
the beginnings and ends of grace periods, respectively.  This choice is
necessary for the poll_state_synchronize_rcu_full() function because
(give or take counter wrap), the following sequence is guaranteed not
to trigger:

	get_state_synchronize_rcu_full(&rgos);
	synchronize_rcu();
	WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));

The RCU callbacks that awaken synchronize_rcu() instances are
guaranteed not to be invoked before the root rcu_node structure's
->gp_seq field is updated to indicate the end of the grace period.
However, these callbacks might start being invoked immediately
thereafter, in particular, before rcu_state.gp_seq has been updated.
Therefore, poll_state_synchronize_rcu_full() must refer to the
root rcu_node structure's ->gp_seq field.  Because this field is
updated under this structure's ->lock, any code following a call to
poll_state_synchronize_rcu_full() will be fully ordered after the
full grace-period computation, as is required by RCU's memory-ordering
semantics.

By symmetry, the get_state_synchronize_rcu_full() function should also
use this same root rcu_node structure's ->gp_seq field.  But it turns out
that symmetry is profoundly (though extremely infrequently) destructive
in this case.  To see this, consider the following sequence of events:

1.	CPU 0 starts a new grace period, and updates rcu_state.gp_seq
	accordingly.

2.	As its first step of grace-period initialization, CPU 0 examines
	the current CPU hotplug state and decides that it need not wait
	for CPU 1, which is currently offline.

3.	CPU 1 comes online, and updates its state.  But this does not
	affect the current grace period, but rather the one after that.
	After all, CPU 1 was offline when the current grace period
	started, so all pre-existing RCU readers on CPU 1 must have
	completed or been preempted before it last went offline.
	The current grace period therefore has nothing it needs to wait
	for on CPU 1.

4.	CPU 1 switches to an rcutorture kthread which is running
	rcutorture's rcu_torture_reader() function, which starts a new
	RCU reader.

5.	CPU 2 is running rcutorture's rcu_torture_writer() function
	and collects a new polled grace-period "cookie" using
	get_state_synchronize_rcu_full().  Because the newly started
	grace period has not completed initialization, the root rcu_node
	structure's ->gp_seq field has not yet been updated to indicate
	that this new grace period has already started.

	This cookie is therefore set up for the end of the current grace
	period (rather than the end of the following grace period).

6.	CPU 0 finishes grace-period initialization.

7.	If CPU 1=E2=80=99s rcutorture reader is preempted, it will be added to
	the ->blkd_tasks list, but because CPU 1=E2=80=99s ->qsmask bit is not
	set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
	will not be updated.=C2=A0 Thus, this grace period will not wait on
	it.=C2=A0 Which is only fair, given that the CPU did not come online
	until after the grace period officially started.

8.	CPUs 0 and 2 then detect the new grace period and then report
	a quiescent state to the RCU core.

9.	Because CPU 1 was offline at the start of the current grace
	period, CPUs 0 and 2 are the only CPUs that this grace period
	needs to wait on.  So the grace period ends and post-grace-period
	cleanup starts.  In particular, the root rcu_node structure's
	->gp_seq field is updated to indicate that this grace period
	has now ended.

10.	CPU 2 continues running rcu_torture_writer() and sees that,
	from the viewpoint of the root rcu_node structure consulted by
	the poll_state_synchronize_rcu_full() function, the grace period
	has ended.=C2=A0 It therefore updates state accordingly.

11.	CPU 1 is still running the same RCU reader, which notices this
	update and thus complains about the too-short grace period.

The fix is for the get_state_synchronize_rcu_full() function to use
rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq field.
With this change in place, if step 5's cookie indicates that the grace
period has not yet started, then any prior code executed by CPU 2 must
have happened before CPU 1 came online.  This will in turn prevent CPU
1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
thus preventing CPU 1 from being subjected to a too-short grace period.

This commit therefore makes this change.  Note that there is no change to
the poll_state_synchronize_rcu_full() function, which as noted above,
must continue to use the root rcu_node structure's ->gp_seq field.
This is of course an asymmetry between these two functions, but is an
asymmetry that is absolutely required for correct operation.  It is a
common human tendency to greatly value symmetry, and sometimes symmetry
is a wonderful thing.  Other times, symmetry results in poor performance.
But in this case, symmetry is just plain wrong.

Nevertheless, the asymmetry does require an additional adjustment.
It is possible for get_state_synchronize_rcu_full() to see a given
grace period as having started, but for an immediately following
poll_state_synchronize_rcu_full() to see it as having not yet started.
Given the current rcu_seq_done_exact() implementation, this will
result in a false-positive indication that the grace period is done
=66rom poll_state_synchronize_rcu_full().  This is dealt with by making
rcu_seq_done_exact() reach back three grace periods rather than just
two of them.

However, simply changing get_state_synchronize_rcu_full() function to
use rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq
field results in a theoretical bug in kernels booted with
rcutree.rcu_normal_wake_from_gp=3D1 due to the following sequence of
events:

o	The rcu_gp_init() function invokes rcu_seq_start() to officially
	start a new grace period.

o	A new RCU reader begins, referencing X from some RCU-protected
	list.  The new grace period is not obligated to wait for this
	reader.

o	An updater removes X, then calls synchronize_rcu(), which queues
	a wait element.

o	The grace period ends, awakening the updater, which frees X
	while the reader is still referencing it.

The reason that this is theoretical is that although the grace period
has officially started, none of the CPUs are officially aware of this,
and thus will have to assume that the RCU reader pre-dated the start of
the grace period.

Except for kernels built with CONFIG_PROVE_RCU=3Dy, which use the polled
grace-period APIs, which can and do complain bitterly when this sequence
of events occurs.  Not only that, there might be some future RCU
grace-period mechanism that pulls this sequence of events from theory
into practice.  This commit therefore also pulls the call to
rcu_sr_normal_gp_init() to precede that to rcu_seq_start().

Although this fixes 91a967fd6934 ("rcu: Add full-sized polling for
get_completed*() and poll_state*()"), it is not clear that it is
worth backporting this commit.  First, it took me many weeks to
convince rcutorture to reproduce this more frequently than once
per year.  Second, this cannot be reproduced at all without frequent
CPU-hotplug operations, as in waiting all of 50 milliseconds from the
end of the previous operation until starting the next one.  Third,
the TREE03.boot settings cause multi-millisecond delays during RCU
grace-period initialization, which greatly increase the probability of
the above sequence of events.  (Don't do this in production workloads!)
Fourth, the TREE03 rcutorture scenario was modified to use four-CPU
guest OSes, to have a single-rcu_node combining tree, no testing of RCU
priority boosting, and no random preemption, and these modifications
were necessary to reproduce this issue in a reasonable timeframe.
Fifth, extremely heavy use of get_state_synchronize_rcu_full() and/or
poll_state_synchronize_rcu_full() is required to reproduce this, and as of
v6.12, only kfree_rcu() uses it, and even then not particularly heavily.

[boqun: Apply the fix [1]]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/rcu/d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paul=
mck-laptop/ [1]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcu.h  |  2 +-
 kernel/rcu/tree.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..f87c9d6d36fc 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp=
, unsigned long s)
 {
 	unsigned long cur_s =3D READ_ONCE(*sp);
=20
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STA=
TE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STA=
TE_MASK + 1));
 }
=20
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e4c0ce600b2b..f80cfdc3ee3e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1801,10 +1801,10 @@ static noinline_for_stack bool rcu_gp_init(void)
=20
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
+	start_new_poll =3D rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	start_new_poll =3D rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
@@ -3357,14 +3357,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-	struct rcu_node *rnp =3D rcu_get_root();
-
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
 	 * before the loads from ->gp_seq and ->expedited_sequence.
 	 */
 	smp_mb();  /* ^^^ */
-	rgosp->rgos_norm =3D rcu_seq_snap(&rnp->gp_seq);
+
+	// Yes, rcu_state.gp_seq, not rnp_root->gp_seq, the latter's use
+	// in poll_state_synchronize_rcu_full() notwithstanding.  Use of
+	// the latter here would result in too-short grace periods due to
+	// interactions with newly onlined CPUs.
+	rgosp->rgos_norm =3D rcu_seq_snap(&rcu_state.gp_seq);
 	rgosp->rgos_exp =3D rcu_seq_snap(&rcu_state.expedited_sequence);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
--=20
2.45.1

