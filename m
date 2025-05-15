Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B20C487
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321328; cv=none; b=V5Gy3WThp/Mb1hLnPvME1o9s23hA09b30Pvlcac4r0jo267pnk4yf0IID6MAXz8vQR7cRzImoubZQwHh3k2wq5uvQ1Arj8wWBvUK73+h70RRCb0olIju8LI3oiLnH7gi80omIPVMZaQRAupaJtkYoAtYadg7mix374wY6Y0HTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321328; c=relaxed/simple;
	bh=rX0s2QYnVYFJWqRAuYNWPcSnMx3/HZszG7QwJ/X9lD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMtURldJBgfmdJDEsDwObek5KtJ8vGvL3TWQMvEQcv7ICxnL/AIWX0HtNOtUW/6PE/Ytneq4XDV9K7THGQDVDbxbk0uBhxNXWh4w5jkk9JzsC+ddMW2ziWonQaH8cIDh4wK4kzdHhscChDE6ZVA6eNRtPRsy/WJqrt68jkGaHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPRg3cyT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPRg3cyT"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47e9fea29easo359601cf.1
        for <rcu@vger.kernel.org>; Thu, 15 May 2025 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747321325; x=1747926125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX0s2QYnVYFJWqRAuYNWPcSnMx3/HZszG7QwJ/X9lD0=;
        b=lPRg3cyThW15+x2pe3WxNZhZ2EMSy9wb5xQjZVdyLGl5+Hgo9ufR91mmycLm6SlIpw
         5M7hmvR1q+zfofajQSAHvTyuUai7VCdDpD6HBSbMv0aD5i4tZt2f95coyHTjMbZ8jBSh
         6Ii4pMhDv5SzPCeAL2JRZ88CDHhvy50u3LMSRFH1evPpXmDdKuSJt5CTksKmMIwoTeNY
         fNCPWV6pyT0vFzWiuUmRsFrg7tfLsgxgg/BWh9SMRf1rE7Wzzgw+ikZKhPefCXP0HFL/
         tEBK93zxfps5d7t7/BW+3d0FjdDEB3dM3TkVrmnFPkb+QXF2lFeWltaFWSvOY0pOIdVN
         eAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321325; x=1747926125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX0s2QYnVYFJWqRAuYNWPcSnMx3/HZszG7QwJ/X9lD0=;
        b=nLTo8VE7x2agqIrKRtjAErr7qwiB7UzCK4L1Zba/cIcS+qnP4A0AMsy4Rxd+1KbJan
         ryWNUCGQJ3LWeztzp1Zfrdp0XibE9H9Xu9nIJmVP0CgomYhSR1NJrmG9zUQavRZiW+ya
         ZhUxsbZaGTE14eTs+EBV6GcqMQRHZhii54K3USrYpuvYG5N8XV86HPEjg1cpLrR4i6D9
         ZmbRAe/go0dtr2Ymmzv64ts0ORNfKQaEJkh81F1VXqR3WS8EsT+12P+ese0ACn5lUXhw
         gaqP52P5fS/my0tiUgdMiiUDhGu8QoCKbeQSWrlggDvXdHxfkNdq+bxXkHPE+uPxqlff
         lECA==
X-Forwarded-Encrypted: i=1; AJvYcCUwuJqyeAiwcNg5BALzU0QyKTdDX2DfDgWGIOB7tIccpG2doQjKtlW+Q+5RKciHK/CbubA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBnSSSymRyGbDL4R8CvLWVGQP1dySL/xfeAO8cfibOKVD0ENj
	l3mQBqgHoCLId30vYKQFnlbEibto3OARZPYwL5/enYbJLsLbEAbQd+NNVd+QrB3360Q4oik21jY
	b1w7C31LvaOw8d/2fkF/SCNNYLHT26211QhOit6mc
X-Gm-Gg: ASbGnctq1kNg+9B7c0rUSQZLIvKVNIvwlXjZHrBUf1hWCKCD92xFmY8N10w/GfHB0Tr
	DdqRnBemUeZxZGrMeIz7OKJmMRkLyDo8LleBQyJ1tJqk1VQABOAHJbS6l6U7syHd828IcQjL3uO
	v4pvbu3aMANJxdX2/mTHBGdpCakS9/RhojQvEP2vtQ7ojL7TeZE4Bb3z6WP4SJ6A==
X-Google-Smtp-Source: AGHT+IHlN4zcoE/AVgqKFO6PNyDAs0OJWk7DAZ9l630dsKTZOK6vvHYJigslJVBGvvhholDbFz4KBp/F2GL3Hwxq5G4=
X-Received: by 2002:a05:622a:243:b0:48a:7cd7:7e02 with SMTP id
 d75a77b69052e-494a1dc992amr3943931cf.18.1747321325103; Thu, 15 May 2025
 08:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz> <266cb5e2-f946-414a-bc08-193c7e6e5f19@suse.cz>
In-Reply-To: <266cb5e2-f946-414a-bc08-193c7e6e5f19@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 May 2025 08:01:54 -0700
X-Gm-Features: AX0GCFt0yj9GDMcdc4GBxWZEFJDfafuu_5skAXnZcVY2juBksjM63TxLUcwCVqc
Message-ID: <CAJuCfpHFnx=XskV3driqyY6pSeOFgYzgwepVS3MudeQ50Vv2Mg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 4/25/25 10:27, Vlastimil Babka wrote:
> > Hi,
> >
> > This is the v4 and first non-RFC series to add an opt-in percpu
> > array-based caching layer to SLUB, following the LSF/MM discussions.
> > Since v3 I've also made changes to achieve full compatibility with
> > slub_debug, and IRC discussions led to the last patch intended to
> > improve NUMA locality (the patch remains separate for evaluation
> > purposes).
>
> I've pushed the changes based on the feedback here:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=
=3Db4/slub-percpu-sheaves
>
> You can use that for testing/benchmarking. Thanks!

Thanks! I'll give it a spin this weekend.
