Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99700204F9D;
	Mon, 16 Dec 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354485; cv=none; b=NB5JjZNoy1o0/vP2F7z3VflgDCphs+QGsD+goQ44uZt2RS+0bEp/asCqdAgYsk6ND1SCmYJlRstZEauCvzx9ZwpHmumuTYpFJvJwFwvgSjhPyJijNFBQaZLD46dfIkDjrM1BuyJnXvvRx6TOxxy0x0ed8GuvdiyRN18pAj6wA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354485; c=relaxed/simple;
	bh=Y4+RaFEUVgorZXPQUJxLroiELv0/GDnz3FbrFD2naZ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TblFsb/r+xZdn6YkEiKEofOeVh7th6XgD10X/GEGCmsJFo1tDDu98eyXL5LM2xyXmnBUZvmSDYMY7vcCnYbWLSEjKB2cYjYeiOO2+2YB+hzLEi+N09LukrWpLhv2ruWu/IbVIh4YfVMf3uVZXxYrbLa9OuDmm11UpCk4VVn0RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUCxq+Mx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUCxq+Mx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so4387099e87.0;
        Mon, 16 Dec 2024 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734354482; x=1734959282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ECZ9W33rRcIg6/SsKb6FX2aMBi6kGOjKIlwyw1Rluo=;
        b=hUCxq+MxuBa2BawmqVAsRTRdM3Y2PyPovyoFV2KcorzxQ4vlB+8KlwTrGDyWyqaXZ6
         KTgIdcAP/FwQ2voRP3Bg3Tzmh3/D3AQ4bhKhW6hcLki69QmUVOrdOMSOjUpRHShRnURm
         01CLUhPq3ouwk0ljL58HCQYhhQahcUndAfN5/tA+XJYEcPZi7dUUxkoA9ab8UReW+bf5
         eJzESmmDHU0BCtL59LW1nRMEgGnGoz1J6P7mlv8v8jv9GAuxFvLJQp7Pe4k1uOHc7Ln9
         4CIXFazK2Cr7uPxJnIj7re0JsutVFVAQ9nWpCJAEoR1jY9cNVeDSyZ4DWwyENkzZ5exD
         Nrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354482; x=1734959282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ECZ9W33rRcIg6/SsKb6FX2aMBi6kGOjKIlwyw1Rluo=;
        b=DQgKHwIFhlT1QZHM5ZU7gp8Ag/MNTvScfDuzmQrfopDi9rjBAjbl6iY2elhotO8LBQ
         N6fysGO9Tckr1sO/pps61DZiiUZ5t/EFEByxsrpzZsEjxcLt1j7Cwf0NVnamj7kjNrut
         qe7zIOFdVs5OfInRzpZ2veQj9U7oQ0iz2eOOu58sqh+QhD6X/Kiam340uJmmUxQ4qCtZ
         yxzQHW62ssAcuSJSUS4P4b0pyzoODLrPwjUAUWmUP97tWx9X8nQ5xpDoPI+hbgVGf5+u
         DkeiA3tHd1GJpB3Yw1Cxjr+PDEfpLHH4Nj94FGsxOgdSAlg2hpRPMSW8sMm1fQ6Jtu9V
         OmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWLMo6Ai/hm1pfh1WOkOlvayKSPKPyuO6PvlkFj6U6cZ1MIkXMSI3fhwIY/d6zF+T25a+xxL93jgphwC8o=@vger.kernel.org, AJvYcCXt5hctImd1LWP2XuJFTdsZJhzIdravNBewNSKDWPvR/rRRByykQM/3SzcBLwo3Rg0WrSWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9PrXVAY5HulHEobLiB0c67+UwDkQVa1XpJUfXC0NKQrVscWe
	nCQGr/GKcJe5E/SjbDcnsXDhkWuyjNxPUlqbNmy4bU/9w7L2/jrO
X-Gm-Gg: ASbGncu/sdys1RiA28yIamz+IpDrukPF5PHk/6pSAclA0sL3k/DIgV/DkDukoZ1duSF
	e3f5aYAtAbBzqQs7v1FiUIHQAz/Rwzg9fnH1Xhmra5GvbjJD1b1JfeHu7vczv+XV/jT/YkU7FOS
	sm7cvw9KQHQxjqTZeD53pCwog9Kt2z2Xb/obQEU4SjDwspiOaq4DqzNCBYTbHPDKV/1vc+5xPd5
	raF6EnSajMFrl4hE929idLUTLcICh1lXKK9i7VuNOeb8WWlCo1ght/VB61+J27RXp2UyrZ35tlG
	E5Y=
X-Google-Smtp-Source: AGHT+IGvssAaGFYaHuZ7FHi0ApzEdQZDYi0WzqMjsCvLHY9xA0k9z3GEtsc8l0unKMiNQ7lYcATDTQ==
X-Received: by 2002:a05:6512:224d:b0:540:1fd6:4e4f with SMTP id 2adb3069b0e04-54090556d1amr3110791e87.22.1734354481506;
        Mon, 16 Dec 2024 05:08:01 -0800 (PST)
Received: from pc636 (host-95-203-7-38.mobileonline.telia.com. [95.203.7.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1394esm844891e87.187.2024.12.16.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:08:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Dec 2024 14:07:58 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z2AmLkyTF1h7FNvB@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>

On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> > Hello!
> > 
> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > here:
> > 
> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> > 
> > The difference between v1 and v2 is that, the preparation process is
> > done in original place instead and after that there is one final move.
> 
> Looks good, will include in slab/for-next
> 
> I think patch 5 should add more explanation to the commit message - the
> subthread started by Christoph could provide content :) Can you summarize so
> I can amend the commit log?
>
<snip>
mm/slab: Move kvfree_rcu() into SLAB

Move kvfree_rcu() functionality to the slab_common.c file.

The reason of being kvfree_rcu() functionality as part of SLAB is
that, there is a clear trend and need of closer integration. One
of the recent example is creating a barrier function for SLAB caches.

Another reason is to prevent of having several implementations of
RCU machinery for reclaiming objects after a GP. As future steps,
it can be more integrated(easier) with SLAB internals.
<snip>

--
Uladzislau Rezki
