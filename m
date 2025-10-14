Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98198313532
	for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446691; cv=none; b=YbN6aAntxl6hVby3MDlaHAMRG7xuSmSJRusdBegRkoWdUT3eMLBfkftKWOQYvnnzogG10HYlefHrWtD7ZPkR78JlqZvNNLKduEdDLXmYK1LjhL2SoKpJC9+ZNZEMGAfPBbvKZJEcz6IBGiCacAyKLUw1Ewd91GYKGib8ZmfwOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446691; c=relaxed/simple;
	bh=K2g5fcbeoiLEypmxm4zdDfAPkL/Zn3ngXE1+qFzQ0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5uX6awmFMRb/06+9eifWaAFv6Ulc1t+G9Vq2aRdIRztpMgSWblcqlrvSKDRfvJvWtn8X2RDr6cb+CJorUu5LypVYnXKnG+ajAXogpFmJjkmqCO8+mrZanlLBOPeu7qwq9X3/HIB2XqGKNIWsDt7/kF72zSMmUKY+JuJxuS9Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F25wjcbo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F25wjcbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760446688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
	b=F25wjcbomtI84IuH63y3uCwMe59HV5IiwauKpiD0sHsUdXIpr1gs8FLbLTlt7g7NNTucDn
	pxXrgcizjcEAVg5AzEb65bkVPcHPq0tEww1Mu2shf//a/rTUEZQSXBZS3zxgeS0OdkZFag
	2sqexAC7GHWcCfQQUcgenQ5DS7xbtiM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HuJv69mJNyurv6xwe1PVEA-1; Tue, 14 Oct 2025 08:58:07 -0400
X-MC-Unique: HuJv69mJNyurv6xwe1PVEA-1
X-Mimecast-MFC-AGG-ID: HuJv69mJNyurv6xwe1PVEA_1760446686
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426c4d733c4so2569132f8f.3
        for <rcu@vger.kernel.org>; Tue, 14 Oct 2025 05:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446686; x=1761051486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
        b=QsjPnvwunqfrprrKMZkymBgK6VkB7axbuBjRtveB5OKElBxyZIHv1K9mJ4QKk+xv+q
         vUYgJHSVGy9lknlQfh5i8gMQ/M6TGtJaKVi1qojdVNJWemY/Yieo1WBOyZGZWijPtzpr
         oMJ+k6rKdRzVLekjoJNER57MOuKpcHoqPdFTPYaIC3zMOHYJ8r2+V6KhGCAKMDOTssqE
         oqMGIuC9DePyyul6VnQTVyezeaqlHkjMFuPBFh4dsXSPIOn7ISxLei70SK6pxbimGLg/
         RPfWfcsdG4713SFpuZG5JZ3ffJsuaiNp4FY/erdjbodkSsY9xtxSPH1Y/omqbbQVyRVP
         Brjw==
X-Forwarded-Encrypted: i=1; AJvYcCVx4bF6/FIv1ORe6QIw4Yf8+pWczTu8sfxoSKFgFuptciws1E1oMw2fVY717sRns0mrNLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGtWUpu03V+s5qkz0ORs73VVXZ3nCJ5DSvvNjtD0aUDYP79+W
	FKa3r2dMpiJ09I5eTWWCXJYqv78TGLxYY9r9xzum5YsJLzLzkVrX7SMZ6HtiZIniof+9MnoxShu
	QZFh59VIuzXeLydK/Ho8I6B2P7Z8EeDO63eCCD73FZlxikwsY00rnaQ==
X-Gm-Gg: ASbGnctCyJaUBVxF+1mfX0W9lcjTL6E4fLWlNeGGXnmBpXKypsPqUrYDKZBLvURmv4i
	tnwAmLGlG0UlBnhCumhNmRMrJCt52PLH7NO6Kq8CVtmqKGsoYbz7awWKgiJCKHHY1sf750ERI3x
	rUIIRHhfIGyrMi+3tAtjWMUCP1OpmO0tm0PE6LbZa3R5huhgTvnPiDqZynskF1mh6dEArag665y
	Ft3ujhtlxumSv3QTHsoEdMAPCzK2gPXjGA3fdZvZwO2pQc4ZLd3IaH1L2jXWKgtNDa1S42zY07k
	sXRvQG5ub7wbWSDHGyUyOtGhhcmc05wA6yoXgvF23oKAwTlqb9M9MgN6WJ2MEmSUFgVyNChR
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487421f8f.12.1760446686072;
        Tue, 14 Oct 2025 05:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAh3YZ5oKpPdr7WASiDkPJn2IILu8/Rh+37A13TS4n2FwBRRVC0ByNWYf0Uu33Aqxt+5Ldeg==
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487377f8f.12.1760446685024;
        Tue, 14 Oct 2025 05:58:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm23624651f8f.17.2025.10.14.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:58:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:58:01 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>

Hello,

On 10/10/25 17:38, Valentin Schneider wrote:

...

> Performance
> +++++++++++
> 
> Tested by measuring the duration of 10M `syscall(SYS_getpid)` calls on
> NOHZ_FULL CPUs, with rteval (hackbench + kernel compilation) running on the
> housekeeping CPUs:
> 
> o Xeon E5-2699:   base avg 770ns,  patched avg 1340ns (74% increase)
> o Xeon E7-8890:   base avg 1040ns, patched avg 1320ns (27% increase)
> o Xeon Gold 6248: base avg 270ns,  patched avg 273ns  (.1% increase)
> 
> I don't get that last one, I did spend a ridiculous amount of time making sure
> the flush was being executed, and AFAICT yes, it was. What I take out of this is
> that it can be a pretty massive increase in the entry overhead (for NOHZ_FULL
> CPUs), and that's something I want to hear thoughts on
> 
> Noise
> +++++
> 
> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
> RHEL10 userspace.
> 
> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
> 
> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
> 	           -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
> 		   rteval --onlyload --loads-cpulist=$HK_CPUS \
> 		   --hackbench-runlowmem=True --duration=$DURATION
> 
> This only records IPIs sent to isolated CPUs, so any event there is interference
> (with a bit of fuzz at the start/end of the workload when spawning the
> processes). All tests were done with a duration of 6 hours.
> 
> v6.17
> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
> o About one interfering IPI just shy of every 2 minutes
> 
> v6.17 + patches
> o Zilch!

Nice. :)

About performance, can we assume housekeeping CPUs are not affected by
the change (they don't seem to use the trick anyway) or do we want/need
to collect some numbers on them as well just in case (maybe more
throughput oriented)?

Thanks,
Juri

