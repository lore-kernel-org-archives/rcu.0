Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FB14A4F0
	for <rcu@vger.kernel.org>; Tue,  4 Feb 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669273; cv=none; b=SmhZyg1JYJHRW2oJhGYqp7TDd7Yb73VF3rJKLe4AQxR32u18/sVnhntWAuJCsXNbgGdC0TmxvHKrHhBDlB3ed2XUWyaj5BXzkjbujqRw+vfXiwk39b0N5TSXkhUCAHvbWvVukTn24nzG/g2k7EqE8IU2XIweXZyWKqvlO+psIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669273; c=relaxed/simple;
	bh=cfJ2o9rwKkPq6C1hg1fCFc5QY15KpS/o+rOFhbNs27w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE6qnxHMrS7pTDHnwJktevvmZu0LNBWOV3VsHlY849xbyR8gb8bD2Mw7tXd3uish/sFHDsTyk3o38/jdsQFLsL/U+usatP3PonhsLu6+KxKjGgruTBUsil1A57OQRFULwlnF4PCbvObC9T1Qf7eFHLzhf4QrEfLnJznmKwpGH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4eQzOkV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4eQzOkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841BCC4CEDF;
	Tue,  4 Feb 2025 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738669272;
	bh=cfJ2o9rwKkPq6C1hg1fCFc5QY15KpS/o+rOFhbNs27w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=p4eQzOkV3pLzSEaAuUAKKCvLAEQVocUKMMXiarsBBs8UFShaiHg0oOoNct2d6fSeF
	 DIQBCFtrL0qMEjp3DqJyplQSDdkadDJCJl2gGeA/R0SW8KVpx113gjJGs2mcgFoiBd
	 XwuaNflmXXVb5R4pxhHHAvoFISFVpn+NrDf1iErwyrM6TD2Aun3OWzf36VU8Isy2mm
	 Y/bHZHTUJdJbgIFYj/C4ZaPbr1fTvCgljfg+Rkfh8rMeijWMKP1k9cOkkkIaJzOD0i
	 rJukkMX6ElkWsDaq8kHAQ2jSSv55FzoZ1P43E84qAOF+N3lR5ay7AZANuv0EFRNyTj
	 v3gmBQcm0yQCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13212CE028A; Tue,  4 Feb 2025 03:41:12 -0800 (PST)
Date: Tue, 4 Feb 2025 03:41:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/4] slab, rcu: move and consolidate TINY_RCU
 kvfree_rcu() to SLAB
Message-ID: <65af727a-55d9-43fd-a6b8-d6d4ef5fbca6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <5ee3321c-417a-4638-8d9e-77faa5f07462@paulmck-laptop>
 <4fdbb91c-df21-4dab-a165-a4e864625628@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdbb91c-df21-4dab-a165-a4e864625628@suse.cz>

On Tue, Feb 04, 2025 at 11:02:47AM +0100, Vlastimil Babka wrote:
> On 2/3/25 20:07, Paul E. McKenney wrote:
> > On Mon, Feb 03, 2025 at 10:28:46AM +0100, Vlastimil Babka wrote:
> >> Following the move of the TREE_RCU batching kvfree_rcu() implementation
> >> to slab, we still have the simple non-batching implementation in tiny
> >> RCU, and RCU implementation specific ifdefs in slab code.
> >> 
> >> Finish the move and integration into slab. Allow using the simple
> >> call_rcu() based implementation also with tree RCU when SLUB_TINY is
> >> enabled, as its goal is also to limit memory footprint with less concern
> >> for top performance.
> >> 
> >> In order to avoid RCU having to recognize the fake callback function
> >> pointers (__is_kvfree_rcu_offset()) when handling call_rcu(), implement
> >> a callback that can calculate the object's address from the embedded
> >> rcu_head pointer without knowing the specific offset (previously SLOB
> >> would not have made it possible, but it's gone now).
> >> 
> >> After this series, AFAIK only the following kvfree_rcu specific code
> >> remains in RCU:
> >> 
> >> - a call to kfree_rcu_scheduler_running() from rcu_set_runtime_mode()
> >> 
> >>   - probably necessary and a generic registration interface would be
> >>     unnecessary bloat?
> > 
> > I am OK with this calling directly.
> > 
> > Alternatively, you could create a core_initcall() that did nothing
> > but invoke kfree_rcu_scheduler_running(), and then drop that call from
> > rcu_set_runtime_mode().  Up to you guys!
> 
> I was afraid there's some ordering necessary with the rest of what
> rcu_set_runtime_mode() does, but perhaps there's actually not.

I *think* that they are independent, but I agree that it would be good
to carefully double-check.

The basis for my belief is that it is OK to invoke call_rcu() long
before rcu_init() is invoked, let alone the scheduler being ready.

							Thanx, Paul

> >> - declarations of kfree_rcu() API in include/linux/rcupdate.h
> >> 
> >>   - could be moved to slab.h after checking for/fixing up potential
> >>     missing includes
> > 
> > It would be good to move them, but no real hurry from this end.
> > 
> >> git tree:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/slub-tiny-kfree_rcu
> >> 
> >> Changes since RFC [1]:
> >> - Rebased to v6.14-rc1
> >> - Fixed build errors reported by bots.
> >> - Changed where kvfree_call_rcu() is moved to in patch 1 to avoid another
> >>   move in patch 4.
> >> - R-b's by Ulad and Joel
> >> - Fix a memory leak in kvfree_rcu_list() thanks to Ulad
> >> - Various comments' improvements and fixes (Joel, Ulad)
> >> - Rename config to CONFIG_KFREE_RCU_BATCHED (Ulad)
> >> 
> >> Due to changes, didn't keep Paul's Tested-by (but thanks!)
> > 
> > I re-ran the tests, so feel free to add it back in.  ;-)
> 
> Thanks, will do :)
> 
> 
