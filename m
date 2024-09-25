Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82751EB36;
	Wed, 25 Sep 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258568; cv=none; b=WsTqhUbKj2vdY3t6XYoH1N/O6v7NxtszdH2sWhYF+phWKK/5fM5bU4ht6Z2LciHDeWffaonPe5ozhj0my1boabzNtmbD2EiXw8+r9DyJn4sB7lJceiP3g48oVM+6veO9shb/JvupxamfGB9W3MiGT5Ahm+5O3N5evRUfU5mXSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258568; c=relaxed/simple;
	bh=TSXpCzxJJGkAZZjqekI+SAitYmkvK20SEeZGv6M/hX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHAanohcynv0c0/lIMzXCsbvQ6ztJrnQWCLzGROjUc3+li497aQpF0IOErrWALchP8+161eQQt+6Xrp9u0MIUceomTaQ1YBhwaFVFiwUO2GlmHnjElCjRWs+An+NLziBpc2f6xAbBAcly36F02oCkYBVzvyDiyd/JCXf7cpLVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYAtYLIg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYAtYLIg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9b3cd75e5so648894985a.0;
        Wed, 25 Sep 2024 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727258565; x=1727863365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUldRcpWHree9ha+m2OGa8hB6t5ASjRpcAc+wb5KVAU=;
        b=VYAtYLIgINteP9pzQ1MfBBLgiSUyvNQ5W5OJx/TtQAEs3lbXL8hbwkTPGPLOvxJTNt
         vRFWspAI5dpnN0s8/B5uA02b/TEuUZDx/d6FxasWx6MMtdlKQef28kbbNOaao2X2MczI
         O5EDIZbbrh/h+rkwIKFmPhnOSVGLK+O6gfaz4otNlsbPg+e2zfE46TupgrlViOrLMjtU
         IKblqi3cObR4+Gepa/Rud/nHcLz41f1yA/hyvgoKCYxY3BPsVSK1QY301DganwoUzqqt
         zICU1BBT2TlPVniBCoumSBjFrHwJ6JdLedHvToz8a0nDpyysm2kneuGxGPjT0VrvytCd
         16eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727258565; x=1727863365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUldRcpWHree9ha+m2OGa8hB6t5ASjRpcAc+wb5KVAU=;
        b=DLZn21XAWUB14q7mGAFxv8j0FJpstUrqNNoq3OkvrUvQSAE+lszvs1DOacqHmlEoRm
         1rh6vgXHCPoxxIvYQI0FDH6wdVG2ocRjsKQdaL7HNFT91sPUpMf2N06hJZHVnwZawyY8
         IQOAMBeXcdZxUdoz47fLpraOdCcqyQ+omkhuxXELnFFt8314xwnJyFXApJt96N8k3ayt
         mLkHcX2UUrrxSYXF0Gron+caAkcGsVu4hr16dmGpaCkp3IIz51JgMBAs2qvW8ikzGPhG
         tvk38mpttrAtvOo7S9ND7l4OiDzOQkB4LjReJSQ+/Ps4G7Ic9y8/+NMFNM1WydF9AEUK
         4/6A==
X-Forwarded-Encrypted: i=1; AJvYcCUNEeMRjvUXT53kl6AtCN7f1d+pzSO6rMAqapUBcKSD57kje3MxfneA+5nt68gLHJBlYBdK@vger.kernel.org, AJvYcCX60gOpIDtYVU9Xg9lLpGbVgKUCPjWKH0GbvkoJB7rkvgn13TJ84Ly0V4iJuX/uUBd1wG9u@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBBj6o5hrBVSlI1vJ8OlPU455sdnsWeN7PG1xXE6nwMjInC99
	sWok8qYf8kXbeT1aBeK8Zg1xAjD4IGy0BfYTCVpxRMYeeri4YNd9
X-Google-Smtp-Source: AGHT+IGVKuLW3nVDBEzBuAX97uyQGAh+2bW9xcs4xJ8/3Dniq7Tabkb462mX0j8Xz5mFA3BAmLmahQ==
X-Received: by 2002:a05:6214:3f87:b0:6c5:4f37:2b51 with SMTP id 6a1803df08f44-6cb1dd7d5eemr34515116d6.28.1727258565402;
        Wed, 25 Sep 2024 03:02:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4c2cb3sm14896766d6.49.2024.09.25.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:02:44 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0EBD1200043;
	Wed, 25 Sep 2024 06:02:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Sep 2024 06:02:44 -0400
X-ME-Sender: <xms:w9_zZlfj_lGnX7i1MJHglos1v5O3p40lvSzoAquicUECHur6mNKA3Q>
    <xme:w9_zZjMS8TfWWXcSAj6HDM98-vyTLHfQj20CnrBJ8GL_1i1BKeA9XFvjEFh3Pyk09
    _UqwJzmkxuhHNupeA>
X-ME-Received: <xmr:w9_zZujpYmCTAwb-OgZlXVr6Wls40DzG-z5nc97-lUweSkMwq2uYBVgjWuO3QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghsrdhosggvrhhhrghushgvrheshh
    hurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhr
    tghpthhtoheplhhkmhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    gruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdr
    ohhrgh
X-ME-Proxy: <xmx:w9_zZu9zB_-8hCqHAarnASvoUPRQcRM1qcRHz2l3Yx5QgK0B1jftWw>
    <xmx:w9_zZhvb7KbIkILiBCB44zV7mEpOpTxFfIasKXItglHm9_6SJDq5vg>
    <xmx:w9_zZtEofsfLnnQrjGgqG8veq719UZiLtGTYxH0ycfn54Wqr5eQS5g>
    <xmx:w9_zZoO4rJoQEvGU8zaNcCuIDTjgkd1SXk3Uxf8DgASI2n9R77sbSQ>
    <xmx:w9_zZqMOxcRadFYAMYaVpKCa1mjA_YDCEYqpyU4uqLcJOYVTORhwbDYB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 06:02:43 -0400 (EDT)
Date: Wed, 25 Sep 2024 03:02:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
	lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Message-ID: <ZvPfmAp_2mDkI3ss@boqun-archlinux>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>

Hi Jonas,

On Fri, Sep 20, 2024 at 09:41:15AM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 9/17/2024 um 4:33 PM schrieb Boqun Feng:
> > +static inline void *__hazptr_tryprotect(hazptr_t *hzp,
> > +					void *const *p,
> > +					unsigned long head_offset)
> > +{
> > +	void *ptr;
> > +	struct callback_head *head;
> > +
> > +	ptr = READ_ONCE(*p);
> > +
> > +	if (ptr == NULL)
> > +		return NULL;
> > +
> > +	head = (struct callback_head *)(ptr + head_offset);
> > +
> > +	WRITE_ONCE(*hzp, head);
> > +	smp_mb();
> > +
> > +	ptr = READ_ONCE(*p); // read again
> > +
> > +	if (ptr + head_offset != head) { // pointer changed
> > +		WRITE_ONCE(*hzp, NULL);  // reset hazard pointer
> > +		return NULL;
> > +	} else
> > +		return ptr;
> > +}
> 
> There is a subtle potential for ABA issues here.
> 
> If the compiler replaces 'return ptr;' with 'return head - head_offset;',
> then you do not have an address dependency from the second read.
> 
> In this case, in ABA, the first read can read from a stale store, then the
> second read reads the same value from a newer store but only establishes
> control-dependency based synchronization with that store; any reads from
> *ptr could be speculatively executed before doing the second ptr =
> READ_ONCE(*p).
> 
> Therefore you could read the object state before it is properly
> reinitialized by the second store.
> 

Thanks for taking a look, and nice find!

> I'm not sure what the most efficient fix is or if you just want to gamble
> that "the compiler will never do that".
> I guess either READ_ONCE(ptr) or a compiler barrier before return ptr might
> do it?
> 

I think the root cause of this is that compiler can replace 'ptr' with
'head - head_offset' based on pointer value comparison. A fix would be
converting pointer to unsigned long and doing the comparison:

	if ((unsigned long)ptr + head_offset != (unsigned long)head) {
		WRITE_ONCE(*hzp, NULL);
		return NULL;
	} else
		return ptr;

because of the conversion, compilers lose the information of pointer
equality, therefore cannot replace 'ptr' with 'head - head_offset'. Of
course, if we are really worried about compilers being too "smart", we
can always do the comparison in asm code, then compilers don't know
anything of the equality between 'ptr' and 'head - head_offset'.

Regards,
boqun

> Have fun,
>    jonas
> 
