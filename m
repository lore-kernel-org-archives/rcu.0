Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8044360;
	Fri, 29 Nov 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890032; cv=none; b=kiG8CFsukU1sBeObtoQlBOAZjx457Z7/k7tHUYnbMrkmOrsUu3Gfw6or2PPK7HNRGcHN4w3NNjMeutQC21zDrPc0gwZUg+Ld2jx6mNXGRtj+RwRgcnGr8QKi7dCCLlB5yuXy3QUKqA02gBOpV7YS5d3ok69qlWVCfTq2kxCQ4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890032; c=relaxed/simple;
	bh=Cy/ZEnbIjBH6QcsuZHAvW2ybUF95XgUtkUzHpRfLIZc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnQAVuNV5zIQrQq8hgaHS+z1HDAldpjRrOnnCTRqe3dv5CN+4x8BTkPeL00tPUurY88W5bBButROiKDc92IS3TiPtysLTRB61MUAyQCNpSi9mGT+2cczVorj4//qZgxDV6wZWHxfaXOPMwQVGmQoNF6grDzjhr7vY2rRXY7sKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZEPVvlf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZEPVvlf"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so23377561fa.0;
        Fri, 29 Nov 2024 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732890028; x=1733494828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov12DWzgb/UPU3FhdyAKlLO1eWE/ZNSJ/oisuTw+9HY=;
        b=lZEPVvlfL4D8fvM2WQMKB60KLU0HVFRSontxzAPyEMt/vl85p6S0poqiZV01oMsu+p
         qGJk7n+XSMOqZUyjFD9FX64VgcEBf50A9laiT/zZirkwkBX1EH6ijnA5jV9Brup3nnNI
         YhDLkdqj+yflN3CGpiiha5INTi/5Vhf0G98zej7z/BZL6JiVjpcAT9RZeEPPb2p8PZH2
         Fom5U8sPF6PNshjAXiHwNmEt43C5Uaa5rcvtb4FBrtg/M4dYyLGMLvOKNYynKia4Vbb7
         mJYwlbBXu7yUesiNz6KwtLC7WuoccdfvSrkQH5xWxP2fli0Vl7YKC2N1CMRyk85GvPRY
         Cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732890028; x=1733494828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov12DWzgb/UPU3FhdyAKlLO1eWE/ZNSJ/oisuTw+9HY=;
        b=Ip/CjX45wt/76QQqJ301mXxJSqc2ZgK/0FHAsfkbMzLqM47+1FWZyGTgdAuRgTAQLH
         dILwsqNLiLbd4NbHpOBKCy0h+7aYFyWqdb/U1xpz8JjfmGasIIsB0bRHjKZF3SQZm4UD
         JOk++A3igoqfHriFNNreIHRfzwfl6O3gRthaq9nvQEItRresORgAIlNg7SIpvj1Ojwzj
         XPWPLv4rZoURcsH5yjbtbhaafacezSCUeP1rn59dC5tMFqn3JfmKsvEnoNCAYzNgbW0t
         xLm0ctPYLxYSpbNMTop75XhRTcsFmOxH8GKBjrTB6U5eePFq/5TTaZm12lyhoSpGQpfQ
         E3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH6VnTj8X6V1v/qtmv49ynPjvxzlDIDLJ61V54PdtLq/e1boiuHCqOgJn1jKU9tOQ9O+DAXCfm2C6ykow=@vger.kernel.org, AJvYcCX/IyS5wPeJXKrI8b/SmwUUnApKjTeO6r+MbKanuRyZkhhJ7eiYRAzdc+cnLgLVfUoxSwSs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7vX3Q7dc21Kd7MxiBEYA04selj8SR4YzZfv0pgbIfDdmFkCd
	3jEZBVSndz1uoQJZbuJbSUGHjjxlVcGDn0b0e1eMEzfXJ3o3SjfC
X-Gm-Gg: ASbGncs4RIZQL/AfOTVbpES1tEFy5G4cv258KogeLqd2fV3jmeVQAE/ejr2ssY+gsQi
	zJD+c+tNkJ3LjgA4kNAJLGifIb3Semco+9iQKCceJ7t3yupjTPlEyJS94eK/5Io+Ly7Hj48NWyx
	6xgh0CiO4HffEGxK7z+VCZlE5XqfZxiWseMd4uJUS0rB5PUMuKkR1300toFaum+3MaY0Rmqq+/T
	cic4wanWAyL1RjqZk7Q4x8EJOPDTAX+iE9S1lTreAjDgf2L0RJuUXIRP9jx5oYumijzjzc5FgEb
	9A==
X-Google-Smtp-Source: AGHT+IGUT6CEclltd/WGp4YaLqNyRCPTqgq1ZAEUO7JQ+l/iucwpW5srMhSlkIsp2PzbWTTd/GILGw==
X-Received: by 2002:a2e:bcc1:0:b0:2ff:cfeb:cabd with SMTP id 38308e7fff4ca-2ffd6110b09mr76415021fa.28.1732890028116;
        Fri, 29 Nov 2024 06:20:28 -0800 (PST)
Received: from pc636 (host-95-203-21-235.mobileonline.telia.com. [95.203.21.235])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc74a65sm4677051fa.70.2024.11.29.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:20:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 29 Nov 2024 15:20:23 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <Z0nNpyBoD5x2M4jn@pc636>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
 <ZzYsBu_rJWSAcAYf@pc636>
 <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz>
 <Zz3YDI4Bb04opI2d@pc636>
 <a4bd2aef-6402-49e0-9ad6-f353c5200ee7@suse.cz>
 <CA+KHdyXH5X=J2ontChFVUqFx15=VVng23H4gh_o-2Vzfo+mmjw@mail.gmail.com>
 <Z0iZOFAUSqN7cN5Z@pc636>
 <d16bef14-eaee-4917-8cb6-5571327220df@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16bef14-eaee-4917-8cb6-5571327220df@suse.cz>

Hello!

> On 11/28/24 5:24 PM, Uladzislau Rezki wrote:
> > On Mon, Nov 25, 2024 at 12:18:19PM +0100, Uladzislau Rezki wrote:
> >>> On 11/20/24 13:37, Uladzislau Rezki wrote:
> >>>> Thank you. Let me try to start moving it into mm/. I am thinking to place
> >>>> it to the slab_common.c file. I am not sure if it makes sense to have a
> >>>> dedicated file name for this purpose.
> >>>
> >>> Yeah sounds good. slub.c is becoming rather large and this should not
> >>> interact with SLUB internals heavily anyway, slab_common.c makes sense.
> >>> Thanks!
> >>>
> >> Got it :)
> >>
> > There is one question. Do you think it works if i do a migration as one
> > big commit? I am asking, because it is easier to go that way.
> 
> Hi, I think one big move is fine. In case there are further adjustments,
> those would be better in separate patches. That makes it easy to review
> the move with git diff --color-moved.
> 
Sounds good and thank you!

--
Uladzislau Rezki
