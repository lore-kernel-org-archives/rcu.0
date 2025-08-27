Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D51C84B8
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260444; cv=none; b=Bl9B+0Ayp3E9Cvcg+anj5wxPTs3eiQH4yshNGmoAjwDpmuIEIdq593qe6RYr7pjt2e/DqXH9C0d8rDpn7c+wqSScSEE9bM7NkmM3EpTYxF7buFxQszmB89ZBPdE/e2hwsbhqu/KXawdoItAnkwOV8xDgRAcTwsVzn4BT+txyoB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260444; c=relaxed/simple;
	bh=o1iBRenskZYXw/LogpEwmbVORqSVbHS4S2uEOxtc2nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=X3qiL8/lco0cR0iEq1cPDHnbqnheO6aphiwl7K0deE2R77gaupaQV6sCcz4a2iMVL0CJrlaRNNsYTa0cRBL4klm5pTvJq35n+cDVR+uxT4kyuTJ2RUQCtATd0JPuW2b8NxgVZjYhRg5NqDhBGFSJoAudcRfCK1Xp6LrTAl49Ep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GL2QpJq9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GL2QpJq9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b2f497c230so15311cf.0
        for <rcu@vger.kernel.org>; Tue, 26 Aug 2025 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756260442; x=1756865242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWX1UVSegYtqh42uuyT4sZDPXoT9oomNFyTW1xLHoJI=;
        b=GL2QpJq9OuZ/ZoBQdHXDjCW/px0TTfNey/ih6DVt9JorpsoUr3D6Q4FYYxaG+dDSZ1
         EMi6UqiMFFXMdCBjpVL2M5Cmi9fBuo/LJE7y5pLPCZTO5cTq2+hmaSEWxJEgXTQZs8rN
         4SgDxgWun1xQgre0say4qXMYmJW4ArloJVpTe1HWcxfZmThgpwemYjyGXjHMoeNIRNyz
         paZCvq5fEKYuLgTFX7MZGQT58EI3nr7x7MmSXIc92EREuwwYSgwnxPQfdAs+iuuir4Sb
         oG22/kVfXdVO3oGhQugXlxHGTYdpFLxmjZycvz+VaeLNqenQsPSBjSG88wQipxtWQp4t
         h0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756260442; x=1756865242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWX1UVSegYtqh42uuyT4sZDPXoT9oomNFyTW1xLHoJI=;
        b=jtvpsb3NU5WVRbWZLs3Z942x0BZtwAyZxHjCHBjHq7HzSY9RKz44x5xJXFNBHSw1wK
         1j1prQqXROUq4c36UL7AqybnR69LlKZiF39+03u5ArW8QA1BjreJRWeq2rmx5/ALKyA3
         AC1rB18ZCkO2Wly3eG7SUiniui3F0NMamQyRPv2iUuZoe+fQqe/X7hJNm+EcXP0r9N0a
         X+FGWrYGkBkbL7SaC0rsQSxjkkQRS42sRDwZHbI7xOyOA05/70yA+zLKyhXzXYaWveXI
         ckyw7JszAzfffgSID8jg6C53vesDNG2cSXBHbfad2EQtFoK1fZ9CgTquIPMTrxSHDGaW
         WDNg==
X-Forwarded-Encrypted: i=1; AJvYcCUdZY2+He3aJRgVMvY7/ooRqHdWHjSSdUqiDOfhJpi18Ah4puVja77dZTpo6H6I0DyiDm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfcT8Fsf/RwokLjYYasW9CEHagXVEbDEyebjbOJm59em8xhdq
	kvhleoUIGaqzuBFMLFccQxgEVx1RUWkqMmv47qdwHSvurs6OFX/56ssX2mvB23KJsdIQrPKfayZ
	KMX2BwXAjW3jBiWI7K3uLG5n5dlBiHFsiN1YCUWuh
X-Gm-Gg: ASbGncuOePqDO5/2NTnjnUOyNa8/VeeE1k5pQLN80LztZKYsXPG+6sHHogi9HDteeei
	1brlsmJ6EBVzPlOmyYXNsMvKHydxbdwLQ2EVBgEBryY9IyKTk8QwnyDNA0dhEt1DQa4M6myZsRX
	/23b/yGOPzYjjfrr6JmDEFUVysPk6nd+lMOgEaZcJQKln5dZ9E4tHdJXSpFwmaMeVm+XnCVJw7Q
	Vm9cW2Q/AfA
X-Google-Smtp-Source: AGHT+IFRogYzpdvS27VPQDT5BDVWZvTYES2bLTvixxXlJL96BhN7ryYeZ5qbgFBB2ozo2W0txPoOEgVSyoAgjFH5kAk=
X-Received: by 2002:a05:622a:4d97:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4b2ecb6edecmr4306431cf.1.1756260441328; Tue, 26 Aug 2025
 19:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-12-b792cd830f5d@suse.cz> <CAJuCfpFKjKAAyXgW_SFBXEp9N55txYdayw2h+=cSLO7wLvO2Pw@mail.gmail.com>
 <nhw4odptloo5dzmawss4q3mg7b5mtcfcs2z4flnqpduws7tlfj@hy75m647kp5z>
In-Reply-To: <nhw4odptloo5dzmawss4q3mg7b5mtcfcs2z4flnqpduws7tlfj@hy75m647kp5z>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 19:07:10 -0700
X-Gm-Features: Ac12FXyqChrZHz3YR-zpLBKUsTqUb5c1nq9CXpqMMwcgYfcr33pd3dv9X5JM3cY
Message-ID: <CAJuCfpE8+u73+COnB=SHmjJKHYJncLgdt8VMGCXR3JDDZ0+s0w@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] maple_tree: Sheaf conversion
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:22=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250822 16:18]:
> > On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > >
> > > Use sheaves instead of bulk allocations.  This should speed up the
> > > allocations and the return path of unused allocations.
> >
> > Nice cleanup!
> >
> > >
> > > Remove push/pop of nodes from maple state.
> > > Remove unnecessary testing
> > > ifdef out other testing that probably will be deleted
> >
> > Should we simply remove them if they are unused?
>
> Yes, I think it's time to drop them.
>
> >
> > > Fix testcase for testing race
> > > Move some testing around in the same commit.
> >
> > Would it be possible to separate test changes from kernel changes into
> > another patch? Kernel part looks good to me but I don't know enough
> > about these tests to vote on that.
>
> Yes.  I'll do that.
>
> I'll drop testing first then the feature so that testing will continue
> to pass on bisection.
>
> I will also stop moving tests around in this change.
>
> >
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/maple_tree.h       |   6 +-
> > >  lib/maple_tree.c                 | 331 ++++----------------
> > >  lib/test_maple_tree.c            |   8 +
> > >  tools/testing/radix-tree/maple.c | 632 +++++++----------------------=
----------
> > >  tools/testing/shared/linux.c     |   8 +-
> > >  5 files changed, 185 insertions(+), 800 deletions(-)
>
> ...
>
> I didn't see any changes in the code block, but please let me know if I
> missed them.

I was referring to the changes in include/linux/maple_tree.h and
lib/maple_tree.c as kernel changes and the rest as test changes.

>
>
> Thanks,
> Liam
