Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD515665D
	for <rcu@vger.kernel.org>; Thu, 21 Nov 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204283; cv=none; b=Qnu5p3c9wJeyybxp2A+fEVOpQT6vPbPqgixd/3rCbHPK1oZxpm7oYni7MQDzUTa3QzYr23aANH832L/iVKR03x5YMzHk84zcYLyAEzxzrVp074RKTshJcYt7mv8t+lY1eU/zz/PEtd9/dHwv0njNa3AXDosxJST0vTMhHZbMteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204283; c=relaxed/simple;
	bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eb1S402yUo3KVDaNvQL09JnB/PC9885R3+k27flfxzaUgyiV8HXXErXWBhrghITS/HqlC5NSuvVDfjMT1DhlZ5/jCaJm3a95HmOGRViZYSJIIbwnjSSismdg+/xtDLiuwNnl3HVbNS5wDlbs2b7R7aYqzO0Fc5Lh/7vgepxjLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4SSYZ8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4SSYZ8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732204281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
	b=g4SSYZ8RPW3XHuknO3Zn3A5mDDKlGH9JTZLz+0TD9XLedn0oySxuE7qrqJxr7Zl0HBzwqJ
	G9bLz57WgCKOiaiqn38MNqK8DFlRhUnPLbwc0zRlkKlQCr8NEWVAhFwwKTLKSzyrjuXsJB
	iZ3joCCbETAl44D3ARVsbnFia/IYZFU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Zs8UC4tXPxuvrqTuybPXDA-1; Thu, 21 Nov 2024 10:51:19 -0500
X-MC-Unique: Zs8UC4tXPxuvrqTuybPXDA-1
X-Mimecast-MFC-AGG-ID: Zs8UC4tXPxuvrqTuybPXDA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460e1786265so16772411cf.2
        for <rcu@vger.kernel.org>; Thu, 21 Nov 2024 07:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204279; x=1732809079;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqwT6sLOKw3cQNoRLXKYtXYhu38OXiMdpn/8NdnhM30=;
        b=oriNw7GiuE1NJW+ppDlmxQB29Uuco6aFSgSjY4Zn1pI3Hl70cq1yQ7n/0+5f4yyO/8
         HqgH5onugwTStIuzzciVFaGPXMMdprvzJEJ6zwp6Zk6l4zNUndAWh78Oob1Mc/zJAnTT
         UeCX6zoELlxDiqw8w4D/Y/ABYdMSzBan5tRZquMkMoMIlfWDqfKjWslU/a5Ea+lcHk+T
         F1zCoqWN5+2BgasKr/koG02wPbVYyCEGLkTkr9ULAJMimufxQFJo0MYsnP6+nMpW55Gj
         wLAB3clyGr9gfu8lAu7iJFTaNVY597yfATijayBbXTajoce/VyAXaqzBlcmkpICTgf5V
         kedA==
X-Forwarded-Encrypted: i=1; AJvYcCUQZzhcbZNcmjoNCyeWLou/hKS3IIW4hdVo5YKfRC3Njz4SaKOy720Sk7KwFt3Hh1Zm8M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYZ7X8Zb8zjOzJF506zobDCyAt+3YjuU9hc4GdycoHlyqLSFF
	HBQfaaT9s983bvRDLafQWkmwxAIKvhv/RtzAb9U+41xSeQKCsQmNsEd6ulIMfG/+Ak8PUgRsF2q
	/+tDSpz7UXwP0fhkFpn4rPGZT3X4U1o5p4XS57nqLgNyU5LNK3w==
X-Gm-Gg: ASbGncvekorUQvFf3LlcUAA7zp98zb7VaMUQ9PG6dAp2edtTaAY/ERqawwNwpsbb8TO
	H7TwyHpe4fdQMFiSi8fZUx3C6sNMoA+fx7F3ajN/TUvOOeScdP6DvKeaZ6SgV4MGAbuI2YxS3mt
	xQ6smYOjZ/SWLS68e0pmMq1c88AohHOwRLrUq3h3W18wae4PXvsFHGgI2TDVYBjET9ZYGu3rZG8
	Xgi0vFwuznEj0ZLH+drun7Bdq3UI+V5r7rHwQYlsmUkyyquhoH2PSswgcRnta9zcxdZQQFUKweI
	Ad80dlqmKcuoi85PBbiYbtclHFo5MLn51g8=
X-Received: by 2002:ac8:7c4b:0:b0:461:4372:f2b6 with SMTP id d75a77b69052e-4647965fae7mr111014821cf.39.1732204279353;
        Thu, 21 Nov 2024 07:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhhGvXxNF9YG7Wn8RkZZVe3HUI8vO3AoWFe5rp5bueN6AbTjXI6+VbxkAuh2ulevplAsAH7Q==
X-Received: by 2002:ac8:7c4b:0:b0:461:4372:f2b6 with SMTP id d75a77b69052e-4647965fae7mr111014101cf.39.1732204278637;
        Thu, 21 Nov 2024 07:51:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21371sm23699431cf.76.2024.11.21.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:51:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
In-Reply-To: <20241121110020.GC24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
Date: Thu, 21 Nov 2024 16:51:09 +0100
Message-ID: <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/11/24 12:00, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 08:55:15AM -0800, Josh Poimboeuf wrote:
>> On Wed, Nov 20, 2024 at 03:57:46PM +0100, Peter Zijlstra wrote:
>> > On Wed, Nov 20, 2024 at 03:56:49PM +0100, Peter Zijlstra wrote:
>> >
>> > > But I think we can make the fall-back safer, we can simply force the IPI
>> > > when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
>> > > but at least we don't violate any correctness constraints.
>> >
>> > I should have read more; that's what is being proposed.
>>
>> Hm, now I'm wondering what you read, as I only see the text poke IPIs
>> being forced when the caller sets force_ipi, rather than the text poke
>> code itself detecting a write to .noinstr.
>
> Right, so I had much confusion and my initial thought was that it would
> do something dangerous. Then upon reading more I see it forces the IPI
> for these special keys -- with that force_ipi thing.
>
> Now, there's only two keys marked special, and both have a noinstr
> presence -- the entire reason they get marked.
>
> So effectively we force the IPI when patching noinstr, no?
>
> But yeah, this is not quite the same as not marking anything and simply
> forcing the IPI when the target address is noinstr.
>
> And having written all that; perhaps that is the better solution, it
> sticks the logic in text_poke and ensure it automagically work for all
> its users, obviating the need for special marking.
>

Okay so forcing the IPI for .noinstr patching lets us get rid of all the
force_ipi faff; however I would still want the special marking to tell
objtool "yep we're okay with this one", and still get warnings when a new
.noinstr key gets added so we double think about it.

