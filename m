Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F961AA1DB
	for <rcu@vger.kernel.org>; Tue, 10 Dec 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838824; cv=none; b=DUp/pyYwirmsIb54NODy2JR8WT0rHjQD+DetaWsBvD3b3Fx7lzahUYVXZVOlKGOn0RAYPawCKwmWjz8/+TgRBI/FazFOFTfZ3tvZvUNnlQqlXD821eCJjkXMhaskGxNG5zX88OX6W+0uyQ5VDOjnTRYe1gvOlqbzinWLvYojI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838824; c=relaxed/simple;
	bh=XRwYnChJePzqn20wldDIV3wuVph1Ee0m/c4Ln+xEExI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXwkLgfGAHkIjXZQOvc0b0MWLtfT4SaEajtf+dYRDAPKRroeCirzGI5dkXc9wT84a+fHBImJoruGAQ2j3FLJg3a8v5ZfXCYS3oLTbuJQBdTFHQhizjWMp+59Eb2v4QEt7xar/qN54xxVo0Z2W5DTcOuVuzeFYAKPQF315yRyzFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FljvzEpd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FljvzEpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733838822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/HoNuqIEOrVRmdvjmLSRb9lrwGMQMrAipZHJQOxiwTc=;
	b=FljvzEpdB06iFSwqoq1dkPV89rYKuiHy1SALKfidhlZjTENLVKB2tm9sNF7mQW+YcFjb1G
	FXhH3bSaWwghanPZqFScUVVrq5vOrFI/iEBs5voB5r+5B27aiR1fDBtLbO872XLEeZyLYB
	ZcVj/iES5YwiqFfOVqaWj7AGkVbKQ4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-_Kl3dUFAOrOivP2FhsdYJw-1; Tue, 10 Dec 2024 08:53:40 -0500
X-MC-Unique: _Kl3dUFAOrOivP2FhsdYJw-1
X-Mimecast-MFC-AGG-ID: _Kl3dUFAOrOivP2FhsdYJw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434f1af9d31so16320695e9.2
        for <rcu@vger.kernel.org>; Tue, 10 Dec 2024 05:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838819; x=1734443619;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HoNuqIEOrVRmdvjmLSRb9lrwGMQMrAipZHJQOxiwTc=;
        b=OJP69YFxm9rZ2aIuD0CUvK6fYZllRPSmlxKvXhKKcQ4Gdzx47bmxIdpXBlcAbvPDBT
         rjxPs+0Ya0AE90ZDbMk6RoxuHfvuiMq6bo4O1XCEkdTgAg+KYTGN/+WNC48AyynzcEI4
         ONaQhiU1Pc6Bi/Ve90wwlZQrPltFmXs8Di6/qQt92flsU5N5ffqYDXoBA+cjjtmAWTui
         LXg9JIO3c+RQYmdE5scKKcz3EsOaQr2q4gBWBUUxUCv3V153SKJyd6z57u3K8DQwfA9T
         QD6QDbSjZy70dfvBOHxOtKS5nkBeJV0Xw92FW2WaTQ+vEtuTBtuyw8UbgcCn5C8ApDjL
         rUNg==
X-Forwarded-Encrypted: i=1; AJvYcCWSanblcsI7C3MUQey/GnYq9A0Gsd+Nkk5T/DBhRYzDsWtMc1MJqGZWv0PsM0198GdbC/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3QTyi6tEDgSpKZdAaufxfy17b3r6uGgY8nM+QqfHIEcK2ERz
	efDlXcPHCO7RWTAXHefd9DEzRMS6Rj9DPah6FgvKiQpcKwzKuGsvloQNIGnbS0Ke0fvuEEaPSrH
	qseOXCZXnvUnBJfdBaDWW89Cohcs9cAYbfIY43iSs82n2g70nJg==
X-Gm-Gg: ASbGncuwy1PEHo+ZosU6M7ybu/Cx8YN0+/CUT0wx7+n8qR0fpKmRSHORIDrkLtyk282
	vBbSkyQUgmLxeZT0fpBkXmRklxq+gDqG5yz5RxZVbx5WVOFCaUFh+VqlT7J7pQni+EqLy6zVuQ0
	m4EJ8FIGlF2w5YTxj4SX2YNOp7rYj8RAXKjLnVpBmhUv7FH9O0H7htfNubB9tCpeUTXwNjhptdT
	qgfHuzN6+GNdJFiyQkiS1Hw9TbOfuvWsd4TC8heIrSSjsCtCbqnqzCMJR+I88bURrERgAaJohHN
	C3VehrAKkrVREhuuLKFFMsdu5ISwcpFIG9KLFPU=
X-Received: by 2002:a05:600c:4447:b0:434:a7e3:db66 with SMTP id 5b1f17b1804b1-434fffd0718mr34707305e9.26.1733838819498;
        Tue, 10 Dec 2024 05:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX1Bnu64mtb/xieDzhp74HQNT4+QKiGnwf7K+hTkAcz8zIBE2KO+I2nCgWMN/+kxkXTwBWJw==
X-Received: by 2002:a05:600c:4447:b0:434:a7e3:db66 with SMTP id 5b1f17b1804b1-434fffd0718mr34706985e9.26.1733838819087;
        Tue, 10 Dec 2024 05:53:39 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0dd4sm227972305e9.34.2024.12.10.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:53:38 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
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
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
In-Reply-To: <20241209154252.4f8fa5a8@mordecai.tesarici.cz>
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
 <20241209154252.4f8fa5a8@mordecai.tesarici.cz>
Date: Tue, 10 Dec 2024 14:53:36 +0100
Message-ID: <xhsmhv7vr63vj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/12/24 15:42, Petr Tesarik wrote:
> On Mon, 9 Dec 2024 13:12:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Mon, Dec 09, 2024 at 01:04:43PM +0100, Valentin Schneider wrote:
>>
>> > > But I wonder what exactly was the original scenario encountered by
>> > > Valentin. I mean, if TLB entry invalidations were necessary to sync
>> > > changes to kernel text after flipping a static branch, then it might be
>> > > less overhead to make a list of affected pages and call INVLPG on them.
>>
>> No; TLB is not involved with text patching (on x86).
>>
>> > > Valentin, do you happen to know?
>> >
>> > So from my experimentation (hackbench + kernel compilation on housekeeping
>> > CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
>> > occurred from vunmap() - mainly from all the hackbench threads coming and
>> > going.
>>
>> Right, we have virtually mapped stacks.
>
> Wait... Are you talking about the kernel stac? But that's only 4 pages
> (or 8 pages with KASAN), so that should be easily handled with INVLPG.
> No CR4 dances are needed for that.
>
> What am I missing?
>

So the gist of the IPI deferral thing is to coalesce IPI callbacks into a
single flag value that is read & acted on upon kernel entry. Freeing a
task's kernel stack is not the only thing that can issue a vunmap(), so
instead of tracking all the pages affected by the unmap (which is
potentially an ever-growing memory leak as long as no kernel entry happens
on the isolated CPUs), we just flush everything.

Quick tracing with my dummy benchmark mostly shows

  vfree_atomic() -> drain_vmap_work()

but pretty much any vfree() / kvfree_rcu() from the housekeeping CPUs can
get us that IPI.

