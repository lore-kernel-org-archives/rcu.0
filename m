Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241721CC55
	for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901319; cv=none; b=akP1QNN+/PLh8J0FOczS0hmE6iY54Tz66A0WWwux6TkzutO5Xg5iYZ74twOMswGyHHxakzNs+yo53JTCipNVDKBLtyg86evlkd4hDSJjsPvWiOeVstq+jDap5syEN+jFMpzUSDYfeVe+CRbBJZfQWUm3xe/tx2CKrR7dQn3fJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901319; c=relaxed/simple;
	bh=b4Iicc2eppakXkGK/sBXC9U1vYPUw54hUZU/M6kuxkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEkbFye9bsUzbqlkyJEuERl/Vospw5h8ZFkEUOyMTIEhsTD5FAbc8WIiQOBYxQDPYBXoYYTm3GkVI6jd/xUl7OM6VgGWSlCtEPvZfKaKiV2Z+bww0bctdHikH96v5pV3lLQtxG3yvd19OidPV3ly5bj0ixsHdE13q2HFdaKIgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0w95UH2B; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0w95UH2B"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de66881569so166761cf.0
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758901317; x=1759506117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pH/Mra/vNThcOhoVJxCqltpBD+kqqv3l/039qoiWKE=;
        b=0w95UH2Bt7GEzGwCiUfqVXNs8+z3auHhMvE76YMhgJ5uTwAiinNWi6jrK9APbmgaKs
         2oS9VOadmvqyI8OEzUe1P1LHnJ0f71nHkud6MuERjHYBLpXyMz5Z8IpejzYUt+NjtaXl
         f22kHbb0B2ONmPMRL4V1sHSLuJunrrMAE8Cqy4bTznqRt4G5rYJfNkQ/sucPKBF+BQ2X
         OBXr1INxYtGU7lhazZ2kbr0wy+SB39AfD1SX9vd1eB+W1eppHdfzkYtYDEvWX7fbf0DZ
         WbWDl0nr+GdNgTThOYrRWXGqpxD1HC4jDBP+p5JButGAtdnns2pJcMVLylc96/6Cng4e
         KyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901317; x=1759506117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pH/Mra/vNThcOhoVJxCqltpBD+kqqv3l/039qoiWKE=;
        b=XzhI2/s0bRehnhwhVUg2R3nM/ow7fbGrdKUz2islRNLK0QFl6C/5/UpIcS7fK+UYvK
         RMklxh1GXpXU5pz/2B23iAEj8p+8UzPhQNz9oSmHW8urU5qeNBcoyt9vTTRkbRcNu6D8
         LBD3vmerl45OwVfY0j4311Foy7lU+9ugXIGnSXVbWkVv4u99Fm00e8GHpCYLVM1+GMsx
         diKJ+OF/aFFz2UxbqZPEXFTmobqIq3i44qfdcT7XCC7CMn8TPaV8bDrg/VA6Y9Z91QSL
         KKHTkrZO4+lI/vYBKqMWewSaDYriRIYssbR/BW87Pvz4crpd23qAYZePJnmLba2CtUgR
         3f4w==
X-Forwarded-Encrypted: i=1; AJvYcCVHXjukhuV3TX2HM9UhNeOU1AdPpuVMCdcEd8gEOP1WUhKSBJjEV/rP68LOPqeTHqdGx6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQr9JDdtKJSrybJwtd/v+H4em2vUcicw0GyfAt0GUyOaGIfa7y
	soecSF2SzG36yBi4A7pTsvaOyQARNv7lN+SDMhIQtRpOSZpmZ+dMZR+ABj5gc8QHSCNLfY4JJm/
	p6Xpjg9aeWtO3kcn8X4GVaiaUS+eqDp8+Y2HlLah8
X-Gm-Gg: ASbGnctto8BJRY6Z5eO5C/jYosFBNfeY8VSqjrrr7oLrUTxf7ipAUHpAsDLcnbBqJyT
	nirlI/dhc5S9ghp9pjESPe6HrV4DcroCVM2Qny9XbN4jh4tj+PRqfCajoL36Oq3Btodag9itXK7
	moipptladBAjoo90b3v9+jEx3pJK4MPH3cjKFQbe9AC7oGKZBhMDYRAzws2GNUyg3rB4WngVdsW
	jD8wDFqp4MN
X-Google-Smtp-Source: AGHT+IFie57Mb7sKx4CUZ5qKsCQeoeNOTrEmPRiPoBnlLAWdzMBBoHnVt4sefNukmoViqBJmoJjKbHzT5xDU0mO3fA8=
X-Received: by 2002:ac8:7c4b:0:b0:4cf:dc5c:8c76 with SMTP id
 d75a77b69052e-4dec6c15531mr179221cf.11.1758901316443; Fri, 26 Sep 2025
 08:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz> <aMpxnACqmsQl-lp0@hyeyoo>
 <bbda8c25-b575-4e98-b1ae-b103c6598d38@suse.cz> <aMqcXyKRlZggLxu_@hyeyoo>
 <6f92eca3-863e-4b77-b2df-dc2752c0ff4e@suse.cz> <aMqyn6nenR8V_p1y@hyeyoo>
 <bf8b4741-1025-4cc8-b9ed-5b566bdcb2d7@suse.cz> <aMq40h5iOjj8K7cc@hyeyoo>
 <a32bd837-2597-43d0-9da3-1ce5a53b15f4@suse.cz> <40461105-a344-444f-834b-9559b6644710@suse.cz>
 <CAJuCfpG6CSm2iZ3jrwLQA4vVbTMvC=B37q10OL+wLzm-DSRhFw@mail.gmail.com> <80f8bdf8-ce50-4682-9468-9f38e0817e89@suse.cz>
In-Reply-To: <80f8bdf8-ce50-4682-9468-9f38e0817e89@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 08:41:45 -0700
X-Gm-Features: AS18NWARWDrEtqEv7CROqpWdTroNvRVXVK4eBsZm2RsgspwIkCZ14ujtVqZ6vgg
Message-ID: <CAJuCfpG4JYPE0YbzcLCZbtsqkqCrzaRENkBunpvzLC_B5q2vCA@mail.gmail.com>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 3:08=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/25/25 06:35, Suren Baghdasaryan wrote:
> > On Thu, Sep 18, 2025 at 1:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> Expected advantages:
> >> - batching the kfree_rcu() operations, that could eventually replace t=
he
> >>   existing batching
> >> - sheaves can be reused for allocations via barn instead of being
> >>   flushed to slabs, which is more efficient
> >>   - this includes cases where only some cpus are allowed to process rc=
u
> >>     callbacks (Android)
> >
> > nit: I would say it's more CONFIG_RCU_NOCB_CPU related. Android is
> > just an instance of that.
>
> OK changed that.
>
> Changes due to your other suggestions:
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 8220ce095970..fec0cdc7ef37 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3945,15 +3945,12 @@ void flush_all_rcu_sheaves(void)
>                          */
>
>                         INIT_WORK(&sfw->work, flush_rcu_sheaf);
> -                       sfw->skip =3D false;
>                         sfw->s =3D s;
>                         queue_work_on(cpu, flushwq, &sfw->work);
>                 }
>
>                 for_each_online_cpu(cpu) {
>                         sfw =3D &per_cpu(slub_flush, cpu);
> -                       if (sfw->skip)
> -                               continue;
>                         flush_work(&sfw->work);
>                 }
>
> @@ -5643,6 +5640,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj)
>
>         rcu_sheaf =3D pcs->rcu_free;
>
> +       /*
> +        * Since we flush immediately when size reaches capacity, we neve=
r reach
> +        * this with size already at capacity, so no OOB write is possibl=
e.
> +        */

Perfect!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>         rcu_sheaf->objects[rcu_sheaf->size++] =3D obj;
>
>         if (likely(rcu_sheaf->size < s->sheaf_capacity))
>
