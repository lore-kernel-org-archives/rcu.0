Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E72148FF0;
	Mon, 16 Dec 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364513; cv=none; b=moujv59SjFAz0qVyH16cKAjmwH/qU8AeMkxolrX3vv2G6g3RgFzIp6ZrPHtW6qz7W0n8ufoVzdo0SfmZmkZ+gnaVcAkPHot5QpAYgrtL+l0ZUl5NemWczFjBac3WdFmijPA+zIQsby7T/es5HMynW/Fm+wMXvApAKgcG1paq+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364513; c=relaxed/simple;
	bh=0nbYvfl+FMgWZxD4rgk2dorGGAfwN2+YLxXB8iZH/3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0KGWTrt44p+U0gbqvfTTN6cRsUc+licYecTWVV3FfTHho9/mrSxabVViIRP9ioNSijOSnRLEwL2XPxTmNPVdhLGkXkncpUyOoi5lrvRpc3WkcV9hl+GHlBBQtOEfEyRjrmAjCegU4xvjYa73wShduro6nxaoDOKT95Q6Fl9Gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OELftRuS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OELftRuS"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df80eeeedso4265202e87.2;
        Mon, 16 Dec 2024 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364509; x=1734969309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4MwxGKXkpnGddxZqvozu7EvMBr4y+Sd/gZ/o7FRr8o=;
        b=OELftRuS15HJxjrVRkHmrivD7n9FGCQaPJ6bSlW9XyODYvT0mleHJbdGHTy1TlJT9j
         ETE8D7CYMKcDvomj7wGs+T9OqDctP7mm4nYz/Qlcafh0TAzskmlp/+xDOFflB9X6M3A9
         Sjo4ul1TCAyzBH2Ssy3TZVeZ0nyFi9X1CbolgjQCnGEJ9kZC4uSGMVC+f0WfYDr8KEhe
         i0wwEWqAe6q5UF2IT09VsJtpAJAqyzlTnX3fhhPIfAqZnD0RsmtMx2rE8rNp01FjUyH/
         Qf3SrAfqIcMZ5Ta6D5dbAhDhERtRMC6HtJZbrRuLdVOWldubmjti4ZWhgEPWelhkzncm
         IvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364509; x=1734969309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4MwxGKXkpnGddxZqvozu7EvMBr4y+Sd/gZ/o7FRr8o=;
        b=kmOiFPPMP47ReS2DXbOXuEMEWee0p9n8JtoGc+Rixt8+0G2gbAvZvq0Y+nh6MGso0l
         ho8aIV9eBj3+dM3KRKAip1lN4rkkwWElKdrI+cdC1eJX5KxPhsq75CdQLtGTGrVyOIAM
         MYfMMxLfA+NFFqYEwJYbMCtWxdhQWbCJwSVbkzPjHmQblWE1zXPVPUVpWDunoTKKAB6s
         +dHbG3jBf4alxmH2q/k3W3eLvY52KyzLVzRfsAdNTBLKNxmgiw1qzNTda8733tAJkqw5
         IKzKgmzUI+XrRfx9bNGvC9GM11jzSB+47Q/4nDDdBRbzGPKlDuriILYpgl3H79pnGV0d
         BzRg==
X-Forwarded-Encrypted: i=1; AJvYcCVUp2QdAK4O+yAD9jhsG4NioKX/vmmOW60X5/sAO+487O4Ic2yVkv2iA7gzYdp2SqpVgobWi8LUchVBZQE=@vger.kernel.org, AJvYcCVXDTkdM8eaOiB5Oe3xYdlzXuBJ19BUrQHABoduh1GfRVFkh4rbMH9l6bwuGvWsDIroi1gM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpJCDjdQ93TN/Ck/L4Rt+BA4MbczSujPCtL7+JSOyBG01O2MA
	vgX7DMzme/bdMqWBVtGHog0f9A4plVts4q9cBPLRt2oHXKNUnLYvlLwdgw==
X-Gm-Gg: ASbGnct2kKln6/GdFitrwnX7qIbrvxd/gejvkGcogrDWoo50vBrXWX32lC9GeUIiDSh
	mM938bRDdaedSjMs/MAdlQ/gJA7VAnezz07gcpMFjWNhh3wB4PnZGrDaMAPr2dPUB3XxxN4L+zG
	fdcxZZ/5EmlnaGQqQ3nVQDJk3vuLXcp2iN1bxXwjPUT5uIC5fSeE07Gt4ZVac+bJMGZWjVV8p2d
	Llx2vl+PQXOaQG60snE5BOk2vuRa2GEDuEQmVZOhiG++qG9jTrGeTpk/JYppAP1oHkdecJkP5j7
	mRc=
X-Google-Smtp-Source: AGHT+IHipyXOifaP3+K8iCuvtXiW/zxJYksucwXX40y1wvFiHnYHMPRUzU0JA19SL9iMQXrpedJa8Q==
X-Received: by 2002:a05:6512:31c6:b0:540:3561:666f with SMTP id 2adb3069b0e04-5409055837amr4569357e87.20.1734364509284;
        Mon, 16 Dec 2024 07:55:09 -0800 (PST)
Received: from pc636 (host-95-203-7-38.mobileonline.telia.com. [95.203.7.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c005besm910045e87.167.2024.12.16.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:55:08 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Dec 2024 16:55:06 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <Z2BNWpkruY6rJv6A@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
 <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>

On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> On 12/16/24 16:41, Uladzislau Rezki wrote:
> > On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> >> On 12/16/24 12:03, Uladzislau Rezki wrote:
> >> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> >> >> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> >> >> > Hello!
> >> >> > 
> >> >> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> >> >> > here:
> >> >> > 
> >> >> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> >> >> > 
> >> >> > The difference between v1 and v2 is that, the preparation process is
> >> >> > done in original place instead and after that there is one final move.
> >> >> 
> >> >> Looks good, will include in slab/for-next
> >> >> 
> >> >> I think patch 5 should add more explanation to the commit message - the
> >> >> subthread started by Christoph could provide content :) Can you summarize so
> >> >> I can amend the commit log?
> >> >> 
> >> > I will :)
> >> > 
> >> >> Also how about a followup patch moving the rcu-tiny implementation of
> >> >> kvfree_call_rcu()?
> >> >> 
> >> > As, Paul already noted, it would make sense. Or just remove a tiny
> >> > implementation.
> >> 
> >> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> >> implementation with all the batching etc or would that be unnecessary overhead?
> >> 
> > Yes, it is for a really small systems with low amount of memory. I see
> > only one overhead it is about driving objects in pages. For a small
> > system it can be critical because we allocate.
> > 
> > From the other hand, for a tiny variant we can modify the normal variant
> > by bypassing batching logic, thus do not consume memory(for Tiny case)
> > i.e. merge it to a normal kvfree_rcu() path.
> 
> Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
> case (less memory usage on low memory system, tradeoff for worse performance).
> 
Yep, i also was thinking about that without saying it :)

--
Uladzislau Rezki
