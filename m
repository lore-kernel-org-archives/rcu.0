Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7713E41A
	for <rcu@vger.kernel.org>; Thu, 15 May 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321455; cv=none; b=AxtTXxxFcTauk+HLjjE7N2iIffpVun9yTOjVtPwqixWxo9ar/jnskYeLh1eZlS3ZY/ZemOmartIgbgHW63WMRLYE4dZI/T5QSGeOrgTRuHaCC6YtnrIo2DuY90rNa/UvH7m0U0XPH/uS3RJzqFZnFYxwR0rd1tvohTMVDWUrHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321455; c=relaxed/simple;
	bh=hehqUbJr7rLAsfjf8NUGx4WWTp8rlzuMgfHd+H9FD54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcgKpQJBk1kkp6b1BflGEkU1oSyT2Oug/fHNd33ePf6cE8mHiLGHsMPEPVwV5jNv+glArOIkF0+hfP10cA+DOt5De90CUy4poCX1XGRpGj91+V9I/G8DPlsADdbN4BIdJzwHLT4yWaHXTiwM8FFvTiV/e7yrcAfJPWH9L5jyijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/d7PWgF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/d7PWgF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47666573242so389111cf.0
        for <rcu@vger.kernel.org>; Thu, 15 May 2025 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747321453; x=1747926253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TESZwvrO5vJ96YaJ7vnx+FVieN+/kHd9koL3nGIsUYA=;
        b=S/d7PWgFFnnZxdjn3GgcvIu7sS75kTWvNpwtyr9yC1wViDDMipRGI9H27h3PcyY9Jc
         KOGuFkXW/WzVbPCRq3D/cPbal8sRpHHRyI4oQ96E80X1eC8uY99hMWEmERatSz7x/oqC
         rTgnTXok6vfWy1nfGpmHaPXHLRbX5vtj9faH28dY8VD116hy7dkDqEZd/onykO5uoA4M
         mOqcPXAe1ETgcm0q0mFHl6Qv0eODYK/UPdx62fb1J0ZuBA2R2bL/UGkkkxx4thKS2r13
         EVeEFYQ2LhB0iO0KC33d7usd8gKHKKiaOXo1cpAHKXr5Whz+KsoDnQJA3KXVdKOLytrf
         1VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321453; x=1747926253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TESZwvrO5vJ96YaJ7vnx+FVieN+/kHd9koL3nGIsUYA=;
        b=RaOYWii0fq4wAI1WyFIyK1tzAbYB4/U5rOLIfBPI6uVrKstyc4uATXRiliCDvkZLiT
         XrlP6s2R+NeolU8U6tXvvqZkiNzQyNyHYDu/2gfjQDlOsBBmNga/oNdDAGSWphNMMyq9
         ywE51Y02EEze9rxWqLMde/L1bA1jHqBrhecBrkWPb29OHhHJfjWc+lpIhSWthwWqtQf2
         kOY7ADmMyKxXHiLA2XWNeOCgPV0zbVVNdvSor4+hNTPCzvVbuigIDGys9vMXVGNY8STo
         FKSRy22rntzu7qbIlwpatte9rpJmI1vX/aLarfwXpgTYkDL8qEYLQqR812H1LUpPK+xf
         FLXg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2px/1iXC6KvwpXaXdxJ0ZW5i+J07epEbF02AKXeoj7jsdfsi7FdphZp5zugxvc0hiPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVU55972Y43BZuBy2SUEblSitBH9g1YVq+S2HvzAdPofjaBCl
	HjwlKPA3m3U/Y1wf8vE14gIybVS2LDrpmZMLX4yVBAvyo0OClRGsfzQXdHxnPFfNlW2AihgRiPO
	UTs8BZaKyLSyi1zeBuHtpUAI36ic0A9N4vz0Uk7RP
X-Gm-Gg: ASbGncttM30NFqkUQpzXQI2G9U+93YP+eqbSYZsOfgBloSeIzEm6d32W7uk7+WOtm8q
	5laVdmWc1qNaHDA/7jFrp9T9Mbzp/yb4k2BFriH0OfP7dZA3wSMDApUqhRIh3Wy/u7Rvw1DVTyE
	weVRD3W/eyxh/aE0aP9ZGLcWmS4Wm4J6lH7piaM8jaWEctuMLX7iCShHl1lRXgkA==
X-Google-Smtp-Source: AGHT+IFfkR3W5VNelP+GA4ohCT0Dcsb8uCPnGXBpE2Rk1IDYPjmDvQ6kKMdPCaRrMQMfaOuaSbnoPb4rTNAIPHov2Iw=
X-Received: by 2002:ac8:5d50:0:b0:491:8f3c:ce0c with SMTP id
 d75a77b69052e-494a1dd13a0mr4202841cf.18.1747321452737; Thu, 15 May 2025
 08:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
 <20250425-slub-percpu-caches-v4-2-8a636982b4a4@suse.cz> <CAJuCfpGVx2jG+S2ch2hqK=sAdmTcs9dW0kOdopxgLtH4V_wNXQ@mail.gmail.com>
 <f181285e-4167-4581-a712-8e444a0ab2bb@suse.cz> <07f321d5-4416-4be4-9696-00f0d83895f5@suse.cz>
In-Reply-To: <07f321d5-4416-4be4-9696-00f0d83895f5@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 May 2025 08:03:59 -0700
X-Gm-Features: AX0GCFvqG0RSuXzDDSF9fFI7cyINP9lGj2diMh8ie4U2ZfZ3NqqakHD4TgfWFYE
Message-ID: <CAJuCfpG6cCo1WUo3N116DOavmRE6=aeS_s2Hzceqdytgc955xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] slab: add sheaf support for batching kfree_rcu() operations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:45=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 5/14/25 16:01, Vlastimil Babka wrote:
> > On 5/6/25 23:34, Suren Baghdasaryan wrote:
> >> On Fri, Apr 25, 2025 at 1:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >>> @@ -2631,6 +2637,24 @@ static void sheaf_flush_unused(struct kmem_cac=
he *s, struct slab_sheaf *sheaf)
> >>>         sheaf->size =3D 0;
> >>>  }
> >>>
> >>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> >>> +                                    struct slab_sheaf *sheaf);
> >>
> >> I think you could safely move __rcu_free_sheaf_prepare() here and
> >> avoid the above forward declaration.
> >
> > Right, done.
> >
> >>> @@ -5304,6 +5340,140 @@ bool free_to_pcs(struct kmem_cache *s, void *=
object)
> >>>         return true;
> >>>  }
> >>>
> >>> +static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
> >>> +                                    struct slab_sheaf *sheaf)
> >>
> >> This function seems to be an almost exact copy of free_to_pcs_bulk()
> >> from your previous patch. Maybe they can be consolidated?
> >
> > True, I've extracted it to __kmem_cache_free_bulk_prepare().
>
> ... and that was a mistake as free_to_pcs_bulk() diverges in patch 9/9 in=
 a
> way that this makes it too infeasible

Ah, I see. Makes sense. Sorry for the misleading suggestion.
