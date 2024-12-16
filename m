Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9414600F;
	Mon, 16 Dec 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363703; cv=none; b=Wkf1rmtjM4MOu+yTtMf+iY+XBQDpcY1CLb2grgYWh7KjgjTqmht1dAL96e9oSbQkQKzRllZvyXmOmkTPblTrZbiGOyEvxMvg6T6YSM6lVkZMiVmn1PWYW7sppxQiouiy5xzWc8XBiZb7nBpNLi3a8Dg0D5dWgKSVhpXT9mVyUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363703; c=relaxed/simple;
	bh=VHgG9nQxOoWP3myOm0nQUSyTByx6w4PboEpICAqqckw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0OTg9k+CLZwb33oNeBQOoNhcqW0YKnVjIzkM6rwVdgwg/2dMW1vAFFl7vFmnAvpNVbQExGUh1/FXtGIg1cAJ0CdqG6gqmDSveEsNS4Q0qDPodMozyUseXHVDTIm55V5oY+Hp8y6ayxvNX8oHMBUYk8zW7IEGHMXohpHPf7Ist0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na4XQ3b8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na4XQ3b8"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-300479ca5c6so41620981fa.3;
        Mon, 16 Dec 2024 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734363699; x=1734968499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7aZ5E1elxy8fNXRPBOVDihEmwZXkEQnQ3nnyUU06WI=;
        b=Na4XQ3b8ob1CPwWMsoLQiAkBOrZHM2RurMpt0ex3u1h1ZS9bnPMY7jbuUUeG8ijS3R
         RZd9XSNc4GbCSZAvZHhoVj4wx0gm/9r9C16iRd4GoOZTAp/mKyI1pfGXVcTknq3jGkLm
         P0NnpM3KhHGgA9XWI/xwMPRaZP6CCSSKCNeFSfXVb3xN4xxWYZgv48N2c8QznJHq2dq1
         WaZjVSeGQG5iaImDyuMAaeQkNwAdDgrBwMD76vf0T6jtccmhVdrAnPZbKeSOwWZkCc4/
         o7GQCe839/YYENulgOAc2gf6Ogz4v5ZTJDZzB6RjVs8/aVXG8X/6k3iyKcoDYoWKkudF
         ygmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363699; x=1734968499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7aZ5E1elxy8fNXRPBOVDihEmwZXkEQnQ3nnyUU06WI=;
        b=SV0s6xTBRIiVWhCnQqzXJVo2ETmPIhJttH/pYr7dlQuq5bffel5kBjInvwEiJnfkod
         8OgRLx2YM2gSaESyI6L5WcA34q6qw5eyFNebCZS3NrhNJUvX4sXvW5L+oMTPQEu1vmtZ
         5iEgADGupvzmf1wtrqPX2aaMKYHnhX4xUxtxU6mD5vqRt3Kyyke2h6m+CvETFMe/uMm4
         vhv/81SjPCWahrTQ8wO9M9kUiPu6qel9GX6kvTukV2Bhq9PaJjFckBHpL+uBFJ/vS+zO
         9KJNTZkvrnLAabc2NTZoPnlktPuynQ2lqu7RjTUVCSufv+d592L8/TOQF6sF/DvnQavO
         YUxA==
X-Forwarded-Encrypted: i=1; AJvYcCWFp57fD3SNxiHgb83kMghCFUAGudOcDj1c1gxCTTtYvvbqPS4NZ0cAYrYdGSB56HsPeCMI9DamcFpEksE=@vger.kernel.org, AJvYcCWL93fE/JHGyPY5gfYXpG4erQFVjCKEbBdnFM6wa3ybF7dy5ktcrMYNqBO0rIyphipVm7Rl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8HQilK96IgmjmSbsfj/TTLEm9n13zXf/hypo/TmOBiGz73S0
	ropQJ4WdZ1q8ci7yXn8HXUXQDqytfcL0xHtZEPL/jVv/ZRCiHsxn
X-Gm-Gg: ASbGncvXMC5FrBdhqdpHlW5AYzDu7wF9/FfOzOtCJ8lAd+EnUrq2HNN6jShFPfc2dG1
	C0kVeMZRnR+oU1tErckrUCqP1LzxdVjw7Pcg9LtGfQxFQYWjI36z1iQlL65KpP+yZTRQADpctdT
	SsWsXzp8Jt8MBLumgmvmb/evU3jCgFFVFxbhbzMxTTIi3FWSPlWjQVflj2VSzjwExpMfJUaUPOp
	XA4PMM18dH2tvfs2u+ihEbZ1cHG1FBH60Nk0j4PYGn/A1aZfSgzYMBpgpSo4AUZklj/tP/DktIC
	5F0=
X-Google-Smtp-Source: AGHT+IH1RIMUXTV2Hr8dJjmC3yRMluXkGT49OFiAymZjfe6VO3ECBaSlXQU1TRGqiknqzlo2ODhWjA==
X-Received: by 2002:a2e:a58e:0:b0:2ff:d5c3:61b3 with SMTP id 38308e7fff4ca-30254426818mr43039711fa.6.1734363698758;
        Mon, 16 Dec 2024 07:41:38 -0800 (PST)
Received: from pc636 (host-95-203-7-38.mobileonline.telia.com. [95.203.7.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344061e1bsm9781791fa.51.2024.12.16.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:41:38 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Dec 2024 16:41:35 +0100
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
Message-ID: <Z2BKLzOGv_Ki_7fj@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <17476947-d447-4de3-87bb-97d5f3c0497d@suse.cz>
 <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>

On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> On 12/16/24 12:03, Uladzislau Rezki wrote:
> > On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> >> On 12/12/24 19:02, Uladzislau Rezki (Sony) wrote:
> >> > Hello!
> >> > 
> >> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> >> > here:
> >> > 
> >> > https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/
> >> > 
> >> > The difference between v1 and v2 is that, the preparation process is
> >> > done in original place instead and after that there is one final move.
> >> 
> >> Looks good, will include in slab/for-next
> >> 
> >> I think patch 5 should add more explanation to the commit message - the
> >> subthread started by Christoph could provide content :) Can you summarize so
> >> I can amend the commit log?
> >> 
> > I will :)
> > 
> >> Also how about a followup patch moving the rcu-tiny implementation of
> >> kvfree_call_rcu()?
> >> 
> > As, Paul already noted, it would make sense. Or just remove a tiny
> > implementation.
> 
> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> implementation with all the batching etc or would that be unnecessary overhead?
> 
Yes, it is for a really small systems with low amount of memory. I see
only one overhead it is about driving objects in pages. For a small
system it can be critical because we allocate.

From the other hand, for a tiny variant we can modify the normal variant
by bypassing batching logic, thus do not consume memory(for Tiny case)
i.e. merge it to a normal kvfree_rcu() path.

After that we do not depend on CONFIG_RCU_TINY option. Probably we need
also to perform some adaptation of regular kvfree_rcu() for a single CPU
system.

--
Uladzislau Rezki
