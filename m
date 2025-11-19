Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40502E7BB4
	for <rcu@vger.kernel.org>; Wed, 19 Nov 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567103; cv=none; b=sOQq39O2l5JdsP4EFRQTuiEX7MAfkIAB60jmTiqV4uMKxcGPIRVEIQIxAu7gqxd1/FUaMkxFU6S/pMrDe6QFoz0cQMMHXagEohkQUZ7o6I1xMcQoE3jVFqTnpVDAFoHVZ4l/JZiNCFdXht/MmZkgzi3TgZXspv+RVUuEHKlxc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567103; c=relaxed/simple;
	bh=lF3/wQkFtlJa/zIjjnBCdc6gfgCa3H/AlT4oU/NT6TU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VTh1Qj061zbMAOtfVxXZsLvok2DkWStl7jywU/juhGz8jPsZbLL65yH/TPJ+sglNZivCNFS3jTiS3cx5vz9x1Mgr4l0BLsAeXJLZFZVBgsfSe0UskBE4CkevtFZgaIKsKepIV6XejnIhLL9ZUHAGMuxrZckCsMvIg9GmQ3l692w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fW2yfxvG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rme0XlrB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fW2yfxvG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rme0XlrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763567100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk13dNEBENY1o2hkoOmhPMN6DaHaKFtT0pxiR0fZhjU=;
	b=fW2yfxvGGnledmBRbahodz6DnZlNdwjfClGIBaYvlX1FbVb8XkVzXIvNEviea3oB3ptkfk
	JSDSKG2c6OlFAZr3hc4a2WJzH+WNPtPA+mcZxl68kR+zxwBqi4X5XxdvBSA73XJ4YHDRWG
	D/e+pHqZB6jmfBwJqAuxFe2N1zTYKoM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-6qFCwgL0NqmCkkxH4iBKfg-1; Wed, 19 Nov 2025 10:44:57 -0500
X-MC-Unique: 6qFCwgL0NqmCkkxH4iBKfg-1
X-Mimecast-MFC-AGG-ID: 6qFCwgL0NqmCkkxH4iBKfg_1763567096
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so45974155e9.0
        for <rcu@vger.kernel.org>; Wed, 19 Nov 2025 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763567096; x=1764171896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk13dNEBENY1o2hkoOmhPMN6DaHaKFtT0pxiR0fZhjU=;
        b=Rme0XlrBL5fu28WHnyChX2thvns5/B1b00arTjwHJ1zHHgFjtGrjVc4bmO0bZLHl9S
         /N5IU+Z83H3aAzAI5RVZyU3lrK2Z9/r6OON/qJ/h9ZHS6ugRSjkw+/5peCv0xJu7Ljbj
         tipvqgpEuPYC5GJXQSrIak0J3k1/fPG4XfqUs2aC+VO0r3H7FScwNNsSS+9VP4saYcGW
         8czEuzBcdVUqGnLifuMi0BA9JxY99GkHSO/45YSYC9xtdXQacXtk89+NjkjVjrB2hgg2
         mVqFoLv6bw6iYMB7nz3I8VZcsjqt6BOYEVfcFAgxxZdPwURV+XnPz42zDRHuFSUG4lYC
         KK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567096; x=1764171896;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kk13dNEBENY1o2hkoOmhPMN6DaHaKFtT0pxiR0fZhjU=;
        b=JDdMIjnMA7qqL6mabDXORRIqCIf+5MrJw6qlBn0rpvWfTGt59c4jUSjNL6Ghe7K9LP
         e+mymMnFLVZAk9KWgrdGMKKJWHS4hPtVK8mTqAj0gtMZAVMG2CGOLMdy5c5ao5m7XQcy
         zgUPOFciGqGI/5stsIqXWL1v7Ld1Uf/i4bY8OHIQMIZ9cBevanqbl9V946IOnLQOt45u
         1a9o8JixeGy3T7K5uDhGyLuLL4amr7iyunfTYMrcJ9stBfkt74tIuQXEgTGGlZ5cnpnP
         cYlfTz619ideCDEEpRBJ+DlEJE4nDi09PyrfhOx7GNbElmcI+01lAGQlDZDDmLzsZZ9k
         rupg==
X-Forwarded-Encrypted: i=1; AJvYcCWyFLOU/GvSlJNfqCSK2vihfB6c+rBLdsNajCBqzaVMOUS3hEN9YHH9dqZ71ZQkIeNMlGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsj1cXlAf343Dz73AibX4qMW0yBZqLjjdbQ84VVs/7zg4ExlkC
	lsUb7UV6bYBxDilQh+tssjJf5UZSsUgkqyzyrk/rnWvSqtqzmgjbC5e0g6CaNDPz0rvQxQ0xBqJ
	RswZrusn9WsQxz1Qi5lDrdp20q7fQbyFigDPLyBMKdoWsjkPwPkowUg==
X-Gm-Gg: ASbGnctzM/g9TQH/9fd4SM0HqtGOK0fOB7VSgXaifVNkbuyuCoqAHE4xOllUH6eTNWH
	W2bsJLllxRmprj/y0USsD9vdiGYP5c8tyTtiK8oaWksQa6+Qe+yg6eIBmjJLFSiTLebvrJ1m9Mi
	I39W3VZgx2XbDkc8p0wS2snNJR0aUNv5bPq+j1vbMq/vHFWCULyMD0VkWoeyzWuNcUOJo635yI2
	hNDvWSrw2tr5EyRm7ozWqKy6jOtVWNbljkaGOnGRsGEY+acF/B8mcBpcYv6ZhlnELVGq8jv41Wx
	r4QAVi5xhct+aTs19a9r4hGWNnLV5N9VUujxrsmAzIulCgMhMZWaqTSGRFosEasNYjqtpkXfprB
	8KC/Gqby2sX8Zqtjk/eYYFYT2rvYw+5g4RxVwUM+yb5FZ9uCxnIrlYPMOUhhLT/rkN9Ypa4U=
X-Received: by 2002:a05:600c:1d0e:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-4779cc37a15mr119020855e9.20.1763567096254;
        Wed, 19 Nov 2025 07:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkP+NxoN8NdgRlSeWXCmLJ99Tn2hRpBffdqlJtKvc6mMNR3Hn0LkbgzbfrqY0lLueiMZLQiA==
X-Received: by 2002:a05:600c:1d0e:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-4779cc37a15mr119020335e9.20.1763567095710;
        Wed, 19 Nov 2025 07:44:55 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10260adsm53340155e9.7.2025.11.19.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:44:54 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, rcu@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
 <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
Date: Wed, 19 Nov 2025 16:44:53 +0100
Message-ID: <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/11/25 06:31, Andy Lutomirski wrote:
> On Fri, Nov 14, 2025, at 7:14 AM, Valentin Schneider wrote:
>> Deferring kernel range TLB flushes requires the guarantee that upon
>> entering the kernel, no stale entry may be accessed. The simplest way to
>> provide such a guarantee is to issue an unconditional flush upon switchi=
ng
>> to the kernel CR3, as this is the pivoting point where such stale entries
>> may be accessed.
>>
>
> Doing this together with the PTI CR3 switch has no actual benefit: MOV CR=
3 doesn=E2=80=99t flush global pages. And doing this in asm is pretty gross=
.  We don=E2=80=99t even get a free sync_core() out of it because INVPCID i=
s not documented as being serializing.
>
> Why can=E2=80=99t we do it in C?  What=E2=80=99s the actual risk?  In ord=
er to trip over a stale TLB entry, we would need to deference a pointer to =
newly allocated kernel virtual memory that was not valid prior to our entry=
 into user mode. I can imagine BPF doing this, but plain noinstr C in the e=
ntry path?  Especially noinstr C *that has RCU disabled*?  We already can=
=E2=80=99t follow an RCU pointer, and ISTM the only style of kernel code th=
at might do this would use RCU to protect the pointer, and we are already d=
oomed if we follow an RCU pointer to any sort of memory.
>

So v4 and earlier had the TLB flush faff done in C in the context_tracking =
entry
just like sync_core().

My biggest issue with it was that I couldn't figure out a way to instrument
memory accesses such that I would get an idea of where vmalloc'd accesses
happen - even with a hackish thing just to survey the landscape. So while I
agree with your reasoning wrt entry noinstr code, I don't have any way to
prove it.
That's unlike the text_poke sync_core() deferral for which I have all of
that nice objtool instrumentation.

Dave also pointed out that the whole stale entry flush deferral is a risky
move, and that the sanest thing would be to execute the deferred flush just
after switching to the kernel CR3.

See the thread surrounding:
  https://lore.kernel.org/lkml/20250114175143.81438-30-vschneid@redhat.com/

mainly Dave's reply and subthread:
  https://lore.kernel.org/lkml/352317e3-c7dc-43b4-b4cb-9644489318d0@intel.c=
om/

> We do need to watch out for NMI/MCE hitting before we flush.

