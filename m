Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFB6BFC0
	for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740285874; cv=none; b=CU+r3+p3jDgrxTHJJv+4QrUUdFhxiMBCyz/DrbIrlr6BPuSW0TXjcP0Vbxh634ob6VIBL51/CkRbR0QoLCpXSQ6/uZ7yt1kR7H4sU/5AJ4aSlaDUP6x3IsrfOLrFXR7BDtF2UvncV9DHmteufZcHJLNIs7V47zMqdWpgxJ+2hKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740285874; c=relaxed/simple;
	bh=/qwbvaYkyJw5YF01fMDSuEqzTdDeyNg91pSNk7wuNiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We4Yw3MaHJY7GJoBvGiWC9Y4Tt4FepFhIoblk4n7sPdUSV27QxY4uynQRrlzHNUIlvsxi+G83TBxaw7Xl7DGkyPLjqMLykWC1w7MBR9U8DONkTOzvJkwCGXnUwj2Z8WPTWERxsKQV0AWrWNVCl4rD1beF+8mwM+t7LXozHfhe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSodocoZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSodocoZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f1dd5b80so167181cf.1
        for <rcu@vger.kernel.org>; Sat, 22 Feb 2025 20:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740285871; x=1740890671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcGUFpbUyOauzWV1lBBOTXy0eRR4JvnEyo1klZZ4Yko=;
        b=TSodocoZL9n9hVRa8hAM4Td1os2cq9lySQ8NhJW85a+82Qq2QKa8UqVafbC4/EI5Rb
         8JQcxIIFpp3xUV9zuUle42FT6DWlFDqJchfVdAFZvFrj49qmy+wukEx8O31NjvQbQMtv
         FjiFwlpEuhKOfgUbqJrj38iUtPBRmmjJUtCBkWNtzB3b8t4FWjEprTQJcng8WP68sAsn
         BcreLgpBDEpErlzc+Lap+NcrYwzOlWObdJDGLLbXcbVN3LIGqLcVdPgYclWUsuhnq+b2
         sl9Swk7THjxqalm5dnVNPIkCMQ21ChOEfqfWS8Fj7z+IujmsAeXs+l3avu3uvlAN1l/b
         F+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740285871; x=1740890671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcGUFpbUyOauzWV1lBBOTXy0eRR4JvnEyo1klZZ4Yko=;
        b=o9WM8vsKaD9WvlepUd1UQeT3NHgoX/3e/tzqonHkNiys/deBY0RGY8xCc+B4xdx6bq
         5gHCUSHgHnhI7h+7nUZGB1r4rAZEWt9PpMlAQI3JvGn+MKtdr4mG1Dwqfh3utKvh4ae/
         Upgu8Fl6vxlnuTvBq65/KrKuR0YU+sNKPvLRnkL+6JWFP9ZJbAnj9EltQpd3nOl1+0w7
         JhWbo9Z7cD1eNS9KztXZzD25LpcUISHhkgmoTYcqVvXkfBIYah4tXUSgN+RHdS6XNAtZ
         xfqLzEflEm5tc4kPt6IMGihO8EPm3wqgShnIA4TBHi6yLbj49FcQfVOB7shmcGeaIOmt
         iouA==
X-Forwarded-Encrypted: i=1; AJvYcCUs23/UosB40FZj7pdBTmrrWZQCJ/QJZRREMkWSoFFyNtVecSUdQp0WOx/pOHChKUH6oUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxncIsJdQ5UG9tcr7KNT3bmy9hWCjs5yiEu95O/qi4SFV7Qzqec
	U52josyVMdnaGw+bbMgkrOaalxj4bnQIGQvFBA6mku2DLZxXPfzB7txqBt2SOa8C+bsg7FGyhW0
	F04Pj1x4ndimssH/G0B+2A9bItJVckpXn8cuw
X-Gm-Gg: ASbGnctr9oUOfmfp4IvOfciD6IICX2c5Hstkv+IYSNyOC8dGUQOqDHlUwD4tk8jo2zT
	1umCmaztmmMB2uajhFUz/Q7vtafG95anDZOP+gVVok3KR0urCMc3uSs+x0hiDhD7wR8Vr5jy2s7
	i2x+Pv6AA=
X-Google-Smtp-Source: AGHT+IGb46tw+pVZwQoU1jpISG40+sgx+NO0UEx1OrIl6UCn0VBop6mZKH/321hTah7c9P/9I7sBTdiVFXoipsZ/N+o=
X-Received: by 2002:ac8:44d2:0:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-47234ccbf1dmr2354891cf.19.1740285871140; Sat, 22 Feb 2025
 20:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
In-Reply-To: <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 20:44:20 -0800
X-Gm-Features: AWEUYZlMNaCB-YHC0BCj5Vx7RBKFda56BzAx84KjKhycsml2Uuiq9n6JJUULhdc
Message-ID: <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 4:19=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Feb 14, 2025 at 05:27:36PM +0100, Vlastimil Babka wrote:
> > - Cheaper fast paths. For allocations, instead of local double cmpxchg,
> >   after Patch 5 it's preempt_disable() and no atomic operations. Same f=
or
> >   freeing, which is normally a local double cmpxchg only for a short
> >   term allocations (so the same slab is still active on the same cpu wh=
en
> >   freeing the object) and a more costly locked double cmpxchg otherwise=
.
> >   The downside is the lack of NUMA locality guarantees for the allocate=
d
> >   objects.
>
> Is that really cheaper than a local non locked double cmpxchg?

Don't know about this particular part but testing sheaves with maple
node cache and stress testing mmap/munmap syscalls shows performance
benefits as long as there is some delay to let kfree_rcu() do its job.
I'm still gathering results and will most likely post them tomorrow.

>
> Especially if you now have to use pushf/popf...
>
> > - kfree_rcu() batching and recycling. kfree_rcu() will put objects to a
> >   separate percpu sheaf and only submit the whole sheaf to call_rcu()
> >   when full. After the grace period, the sheaf can be used for
> >   allocations, which is more efficient than freeing and reallocating
> >   individual slab objects (even with the batching done by kfree_rcu()
> >   implementation itself). In case only some cpus are allowed to handle =
rcu
> >   callbacks, the sheaf can still be made available to other cpus on the
> >   same node via the shared barn. The maple_node cache uses kfree_rcu() =
and
> >   thus can benefit from this.
>
> Have you looked at fs/bcachefs/rcu_pending.c?
