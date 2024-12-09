Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3966D1B043D
	for <rcu@vger.kernel.org>; Mon,  9 Dec 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755382; cv=none; b=lxuttnX/cwcghI7eH+ijahv8KIPfyWCoe2oX3XufiL86pqIogWSCrWAINK8ZzaUFKVsUj+BuZg1hk8rFs2Gsz8aF8PMS3Nwe6obbHTXwO4bVwUCD2w+2STMasqCxqsLuwQZWBM/IDmWGdLitjQoUoMIYwDDkCCBNzB2JiCDQhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755382; c=relaxed/simple;
	bh=Iiqbjto+vb0aXpNcZOFiu3NWNHXQsyJ41jNpYdodkL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK11eHPRSb/prBXSfqkD749gKZ3kAOm8SRXb5EfxkD1UT2yX7DBnA1eS9B4WBjzyTTzg7m0qyiqRp2r/MMAU5ADumjwlUKiGd1HJp7YKGjt8GJRlzng3hy+VWP6rdeBsTBwhdU9k4oKRIn4YhwdQRQwqr3oWFhYZKtxUQ4IYZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=REDpF6dF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="REDpF6dF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862c78536bso341565f8f.2
        for <rcu@vger.kernel.org>; Mon, 09 Dec 2024 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733755377; x=1734360177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkwsX/4Xva/aw3/I8I2kwIJd9M/PGmCc4Ypj6qQ29AM=;
        b=REDpF6dFhXNy3Vc5phYvhf0EusEPJbM1EBVwSgBXlV6eBVci5wLzMrfgwFHdHkquZa
         22+/z3lfJQhNPvCH2+JpzR7RaczfQzOq2L8iDNFDDziwMSoeL37Z/1ma2jPXs95p4quy
         jJtkjP3/Ck0bVWvFEOOZN19ZLM27x/gxXkV1Q+9nyjbepnX2BYeo+accdUWPnU1RxIN+
         /ePs1EnonFTVgWTOa0FSxdi3Sc44yNHFtPaZwFNqjDpuYmMiDdtKKnnWtPcBowJ7AAHq
         HEyHPt3AM2jKmI4M3C1k/8RSJjGUHUVOEggFuoCsjBgdBtp6BnBV3S8MAa7BuyH1CDsx
         zLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755377; x=1734360177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkwsX/4Xva/aw3/I8I2kwIJd9M/PGmCc4Ypj6qQ29AM=;
        b=GqruqUjfh0g8tDaAG7Fkapl+2zh/todmDoZ2PVUbGnnQ7Arh+JWF6+gE4ZW4sPiuCO
         LffRyIA7EUT5hSRCju8EmWEDr71R+zWbjXlk7MPg1QucWo0S5iHrzKOcd1Ot+tHOnha7
         jtCnhbRYD9ZyyzyHQ+OQECSV3mD4iJKLQeIlKhsyBFJ1sMZuIU9s6v5dG/Da8hpElhaS
         EXcTzOJKP7494aKI3epwcRLX758HbZvxa+dEqFjgy+LZqztF+1QxgBccvvXKhWQaF5MD
         LGqQqDxNxjaX7sZKwCzH7KwbPhAF2Gu+DOxC78zplOecKVue2fHyvzyym8Ji9E+a2IsV
         15fA==
X-Forwarded-Encrypted: i=1; AJvYcCXtCaBmBNjQk66S1Si1ChjSBAuNkMmSKLB2Cd+3AY6G6fyTXrww34Zysnihb+wl4CxA5H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09v6IjaUoxi8imVzGeMTE4f/yTWGmZ+ObufJQQmXUEH9AQts/
	j8WZ4HO4k/+4zH6e9ojMqNlk1Bkd1CaVQJ188/FhJhkUrVwb9p7XJGyRuNtlwsU=
X-Gm-Gg: ASbGncsynt5k+gwDWm71rfySrkhGGt5/Yl+eRVM+KS45d4Zo9CLUuHfudpl70wQNZMp
	j4qwQAz93kGzC2zFky00el/Z/ujFJWcLtfHLQkSfldqZnqnaXDPpyxu+OQHEae9TiAmZktpP6A/
	Fw3gYiliDb1KuHwQ+tisqJo9Bn+PMoxSODP4gfJNNEmqpYpiNdOjDflJO+Cxm/TqZiwcpkLGjk7
	tWgcLf96tMvVFv718ExRc2MMelS84SP9EpPBlFThMyXJ/bhU+AGP3rqgq/gT3DQmAcvwzldAczc
	yrd7F4EuZ75tquW2CIlxuNWnraVTHpjD6VEyjCKiB0XxF2uahPUvRIo=
X-Google-Smtp-Source: AGHT+IFS9ZOU0lVFyWUQ84y6baV41ONm7JGT6TkRTJEtzq0JeBL9l/n9rsr90siOB4OTv3dodfZukg==
X-Received: by 2002:a05:6000:1846:b0:385:fd31:ca24 with SMTP id ffacd0b85a97d-3862b3cea6dmr3365934f8f.12.1733755377482;
        Mon, 09 Dec 2024 06:42:57 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636e05568sm7300809f8f.39.2024.12.09.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:42:57 -0800 (PST)
Date: Mon, 9 Dec 2024 15:42:52 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>, Dave Hansen
 <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
Message-ID: <20241209154252.4f8fa5a8@mordecai.tesarici.cz>
In-Reply-To: <20241209121249.GN35539@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
	<20241119153502.41361-14-vschneid@redhat.com>
	<20241120152216.GM19989@noisy.programming.kicks-ass.net>
	<20241120153221.GM38972@noisy.programming.kicks-ass.net>
	<xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241121111221.GE24774@noisy.programming.kicks-ass.net>
	<4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
	<20241121153016.GL39245@noisy.programming.kicks-ass.net>
	<20241205183111.12dc16b3@mordecai.tesarici.cz>
	<xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241209121249.GN35539@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 13:12:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 09, 2024 at 01:04:43PM +0100, Valentin Schneider wrote:
> 
> > > But I wonder what exactly was the original scenario encountered by
> > > Valentin. I mean, if TLB entry invalidations were necessary to sync
> > > changes to kernel text after flipping a static branch, then it might be
> > > less overhead to make a list of affected pages and call INVLPG on them.  
> 
> No; TLB is not involved with text patching (on x86).
> 
> > > Valentin, do you happen to know?  
> > 
> > So from my experimentation (hackbench + kernel compilation on housekeeping
> > CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
> > occurred from vunmap() - mainly from all the hackbench threads coming and
> > going.  
> 
> Right, we have virtually mapped stacks.

Wait... Are you talking about the kernel stac? But that's only 4 pages
(or 8 pages with KASAN), so that should be easily handled with INVLPG.
No CR4 dances are needed for that.

What am I missing?

Petr T
