Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5013C836
	for <rcu@vger.kernel.org>; Sat,  5 Oct 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147852; cv=none; b=nNrrg9gJG2ZJwW3OfxYAIFkSE1gNV/pAtFnvfPX+9hUhj+LlYzco7DJUKQ/NAucAgsCi8aiK1sIRm6X3isuvec8HdrAkx7Xnm2GGyq97mvnzLoScLN5D2nMAGWqiAp+7ay3qpnxZo1UQOcGkJDxV4+483dZSrqwaj5LHttVJ7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147852; c=relaxed/simple;
	bh=npbBU4EB/OXQqg6L/gxKG9dBNz36EJLnuqdFFqttzZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNVGcwsrT9jJ3q+Fjvbf0hOVH26JHt12W7mhU1c9VsQW5owJaSyjarJhVhxibNDDVqjg0Cq/8GQEt7sjJHAo+mJZlS5bGjWJJVF7a7Y96EO4W3+QJsW/b9ykqXDPrg+y9bBye8xA6IEARkYH5+C7ie/xd9xpdftc9U+bsQ7iVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C9IyiZ9p; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C9IyiZ9p"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2facf40737eso35187041fa.0
        for <rcu@vger.kernel.org>; Sat, 05 Oct 2024 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728147849; x=1728752649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhvgt4CNXD6VdyhO1ydmmdT8s9FGMYClv5PenKYrbxg=;
        b=C9IyiZ9p4XR8mEN0gwXtEZmpJw0golyzwxN5PNNHzjWoZ2oRndn6gamX2q3dEZwzr5
         cVqDCTVfU+AnvRmqmaoTxrHLBF7wDC6FTv8FbmQsZjv5Fzemugbm14BN0M4bx0xctmB1
         7Buq4AYvaghHILMdi6tIpy4PA5FGJn+4+oYZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728147849; x=1728752649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhvgt4CNXD6VdyhO1ydmmdT8s9FGMYClv5PenKYrbxg=;
        b=bROvU5NuKA61KrhQln7lPM39qqJ61dzp/j3vDxiT6ZsNxoPpne7BGYAVGhNi3L+W7K
         4LEKrz+y1LDUCLq3MEBhFpwy/CeKyhI43XevLKA+lAWvVMlGsVEq+6kk87R5rUvFv3Mp
         MLOiU9KWu6j3nx03IWgH6V1R3PEd73nRFyeUoGDRJk4XANtlBSucRcXygXedui9PbiKe
         MzkvUkMU60+lHnOA6D6UjiogDcaRRPCT+nnp9YBlqNeVOdu/GkHXljNc+lrieMvW/3m+
         R+SkDqfn3WRlggMynmg4AJmwCfrrxk6E2wezyI1SmMQEUE60Ow3K/F5PGuQ9COAFoLNv
         RsNA==
X-Forwarded-Encrypted: i=1; AJvYcCUlkJ1Ak1hiYQOA3Mx0KY1owwwpenXbSaIEBh9nwt4rQRlzHgYu3OA7w5ARyUC+QYrs/ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQw/Z+1oDOSPiAzanQJ8tFOFYm7neGQoZzmBEiyY7zwSFla4lk
	Bwm3hgHTee5JEYYWhquHyPNatH/uSNNB917UJsrkOcdH30E+oZOnnrSbE/ClYePALtPAbagA3eT
	yrIpT0g==
X-Google-Smtp-Source: AGHT+IFy9Bs8MhD/6vXD41HjBhvFK623td9VCkvxwypL2r7BEXoGS15quNTQ+qVhGvWUWaDV9XcI9A==
X-Received: by 2002:a05:6512:3b0b:b0:535:d4e9:28bf with SMTP id 2adb3069b0e04-539ab9e9d00mr3110869e87.46.1728147848650;
        Sat, 05 Oct 2024 10:04:08 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23db4sm266776e87.242.2024.10.05.10.04.07
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 10:04:08 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so3922355e87.1
        for <rcu@vger.kernel.org>; Sat, 05 Oct 2024 10:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkx/FcXwoL9Cpg2aNq3ChHkzmNR8sJ49dAppKaqdMFtuQXYT5Z6DsKiPie5biXvIgOTGE=@vger.kernel.org
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id
 a640c23a62f3a-a991bd16c3fmr599542466b.13.1728147401876; Sat, 05 Oct 2024
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com> <20241005161537.GB18071@noisy.programming.kicks-ass.net>
In-Reply-To: <20241005161537.GB18071@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 09:56:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>
Message-ID: <CAHk-=whvxq3378vOn++=ZiOQc9=4N-3ejUWr+dXEJ5ti43kT6w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 09:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 02, 2024 at 10:39:15AM -0700, Linus Torvalds wrote:
> > So I think the real issue is that "active_mm" is an old hack from a
> > bygone era when we didn't have the (much more involved) full TLB
> > tracking.
>
> I still seem to have these patches that neither Andy nor I ever managed
> to find time to finish:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy

Yes, that looks very much like what I had in mind.

In fact, it looks a lot smaller and simpler than what my mental model was.

I was thinking I'd do it by removing "active_mm" entirely from 'struct
task_struct', and turn it into a per-cpu variable instead, and then
try to massage that into some global new world order. That patch
series you point to seems to be much simpler and clearer.

Of course, you also say "never managed to finish", so presumably
there's something completely broken in that series, and it doesn't
actually work?

                   Linus
