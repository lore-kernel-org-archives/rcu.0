Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E87176248
	for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658235; cv=none; b=PD7bEt1TZf1uE5sEJsm1JPHyTDpa43DUmX7N1AxU/TXk1lchi4wHuNhKvtaa9CVy7gldWQEDqKwFbTZJV1AUBXD2W5Wc+TzAa0miy6Aefb4gQ612bcW/ztBMGHBc5VL5h5eos/G1Ik/ajTXJwjqShTexOSzBqDQdX8VkryVp47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658235; c=relaxed/simple;
	bh=XnMvMwMBhk4XwT7nR0OihLx9Krga0OxtnhYr+RCw1oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EovuFxrEsKa+z9i11UseUheTqmWmy8EkA1mNNArOOR9V2rgwgEmbAS+nugnbol86ZvZZAHqTYc4pAi9s4RGCETGehN++MhoARSsm2vjD1dS3WYPaDe6sGqJHFH9v3MivGYDAYzNbTtHNJSupZ7W8auTa2aRwDI9N+m5b/0RlttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ejuM7QkA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ejuM7QkA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so119919866b.0
        for <rcu@vger.kernel.org>; Wed, 18 Sep 2024 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726658231; x=1727263031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=deGMdGgLkdafLLe6g3k5x1mHPfDLyArAU1Qq7LyVhxE=;
        b=ejuM7QkAuEEva3CCZO1LspgqsjSVmJkhuF3mL1RY45EZlQp9D6iQB47AS9nMGqyO2w
         ABNYhNxtvt739G4XOVgsfaavtxYUl2YWrZwwphDlKfm9srVnpO3PK18IboyI3B73VHpg
         trBmOTT5nmsaLAXmNem1UNOJhfC+Gk1JBhl1fWRhqgG84ZmFJmTvRvV7+Xz4Kh7cXqWl
         5j5CSA6269mx+Wjjt7y6gW8AFv00ZWT9K6rTpz6YoEnWxCpQMGVBd7xWTI6loyl4+AWB
         B6RtOn6UZC/pBjd0ncHHmQSSZhzlI9vncn5IIKTSqdpPfljwg4jLGyXRBdmc7XQine4z
         Hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726658231; x=1727263031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deGMdGgLkdafLLe6g3k5x1mHPfDLyArAU1Qq7LyVhxE=;
        b=fKGqY095C8b1LKXayONIPhiMHKwF2a7dio3pFFG0IE/M1T4PbKW4Jc12PNx22/RcD/
         PYLhis3Qc8BYGubpHGpm+G0v4OyCfX1/pfoNFLA23AG4gdyVzXTzjkzGgc2z6NJ1uHyA
         X1sc2wtFUreNmKGC6G0NjtSqbovHezr7Cou1mb6KKH8Z9zN2ymrpnWqFcl1xF48v9CB+
         QkbsC2bBWcFW3mGPBI299wSqNIIC6o8O7i0NHsk0CbCI8IYF32PdOBvGgrKedrcFETOp
         6W8q7rQzw+3ICEM66e4P6QAlKOLOyVKJjvlMIGbd6BDjg1PEtIDgQqxl08x0U0T9q9tE
         YHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxE0pcfUu1oFOW4luVntNhr7FJxB4WrUTJ3/+yeJVbPQddG9zvDnBbI2uFVhwwCsrD+i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqCAGX3NQZykTgNAE2j9yGFOlXHARedP2tbPBiU/cJ2MRm16l
	uM9mXHO3siZVu8FORbLuTncJgUHf5F4X/rpQc/Iaq72jOXvcVvHCFuyRSu51POc=
X-Google-Smtp-Source: AGHT+IEqcT0O/K1e5DJ3jUxfCJKVJ2bCW8ynrWruUc6SYiGDqjCWkd9rDT9dHvznNcVFqSO2GhqOhQ==
X-Received: by 2002:a17:907:60cb:b0:a8d:59d7:f92b with SMTP id a640c23a62f3a-a8ffae3a32dmr2741940066b.30.1726658231269;
        Wed, 18 Sep 2024 04:17:11 -0700 (PDT)
Received: from localhost (109-81-94-244.rct.o2.cz. [109.81.94.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096694sm582699166b.19.2024.09.18.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 04:17:10 -0700 (PDT)
Date: Wed, 18 Sep 2024 13:17:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <Zuq2tVC8GlBJwUJ7@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
 <ZulbS1MvZVVYe-YO@localhost.localdomain>
 <Zuli7SGxkbEbQraJ@tiehlicka>
 <ZuqfZhvWB5ox4nh3@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuqfZhvWB5ox4nh3@localhost.localdomain>

On Wed 18-09-24 11:37:42, Frederic Weisbecker wrote:
> Le Tue, Sep 17, 2024 at 01:07:25PM +0200, Michal Hocko a écrit :
[...]
> > I am not objecting to patch per se. I am just not sure this is really
> > needed. It is great to have kernel threads bound to non isolated cpus by
> > default if they have node preferences. But as soon as somebody starts
> > offlining cpus excessively and make the initial cpumask empty then
> > select_fallback_rq sounds like the right thing to do.
> > 
> > Not my call though. I was just curious why this is needed and it seems
> > to me you are looking for some sort of correctness for broken setups.
> 
> It looks like it makes sense to explore that path. We still need the
> cpu up probe to reaffine when a suitable target comes up. But it seems
> the CPU down part can be handled by select_fallback_rq. I'll try that.

THanks! Btw. when you are looking at this, would it make sense to make
select_fallback_rq more cpu isolation aware as well? I mean using
housekeeping cpus before falling back to task_cpu_possible_mask?
-- 
Michal Hocko
SUSE Labs
