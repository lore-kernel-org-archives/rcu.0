Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E62744E;
	Thu, 28 Nov 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811072; cv=none; b=Qu0iZbM2QS2cAq9moPev0mwXOivMc7Fq2a/RRn07cG8rduAMflMlgiUIypGpSv7Kim4KskOZH9BC07GN44wfovn/gtORjN4c2OApg42mG1OXderZRGtrCue4wAHxnkB4UwmVovdW1PYNqkU7dtAIbevnxJ4RBp4m87vCA+DZU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811072; c=relaxed/simple;
	bh=FGciKnPDcRkg1bOrwO22fEEvYEsHPDA/mpLdfNp5BHo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXM1z1u8uvzYtnop4gXp6vFrjX3hIJo2Wp7+aWNNg8QuyxCBs6kvd/nD9pWOAuyKBrQ1YCO4MbFsXUQyvGrfB2G/ThAwaCCmxdp1S0/VyhvKnGeiHDQhiWt1KamTblzBKSt0JFNG/bW08x06o3Znq+T3RMnin/tAJbrSA53gLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVdqVCWq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVdqVCWq"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df1e063d8so1232023e87.3;
        Thu, 28 Nov 2024 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732811068; x=1733415868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AItm3NvzzDvmWyA58LEOmeT/SsjS5V1o9D+FQFxzrEk=;
        b=cVdqVCWqv+amWNCVocsy6Uws+8F9mR0ohmgaHdeTgOmcLhwb9x3vjjV1lZBfoG0izL
         9iExo+DHU60mtnSsKnCZT65/5jfmtWSuM6F7wk3qzyBBa28T1eVoR+GJYz8678tFx8rO
         fxWi7sARJE5WDXTlKkGIwoYI/Tbr5q6WmUzG5k8f/4GFJWNItuCVYZXbXMEo//b2x/Fy
         meCla7L4O4S8fO5Fk8TJo4aqwmDds1Egh04J5sESVUvx2EOar8Ea/rTjqAjdGeljAvM/
         w38tIjYOZ8lSOBFtbcrNDtvhrwDBlaFvkrOU7ypRfOFDW5CohO/TBQn/fEDPYtr3Xndm
         ZlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811068; x=1733415868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AItm3NvzzDvmWyA58LEOmeT/SsjS5V1o9D+FQFxzrEk=;
        b=LP6M98v7qU2tgz5B2OqZf0qcXQlRWtRTo3Y3xOnVzbgIIEBopi2G8VuzhkycxfVyIZ
         rWdgZLO5Hrp3xsadXq70roF3SS1EjeZTHFSZKe4E2Hsdbsz61UWYHOM5gd53RxbBCpmh
         sw1fQkqn+vGtEToMbdAkqgDra59i3z3k5sbcQJE7C8fMbwuc9aOIXWymjPNYwz5Tkvq/
         sOTiqps6mOPSotuQsNeeBoiRVL8EXmcMcl4QJTSG94lYJxn+cG9humzg4Zg1EMOCQAlF
         cISqlHg6Tpr4EhIALsPAv2rbJoczG/ZGsICARpQhpc3ZcDrEABUB8de1xvJxzemxyXQ/
         de5w==
X-Forwarded-Encrypted: i=1; AJvYcCUUNHsBWoOasTCTLpFgCyKz0fRd8J2tk7ASYrUPaH/8OTLt7kOUn7ocib40vr7KIQPwBwXyaxAuXZGkCdM=@vger.kernel.org, AJvYcCV0fTyzsL8IAjc8dgNPFHDw2F3bwyeyDszPuUzn3jxx1OLz06wMc1XYOU6xKs1AHySUgJvm@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcOCLtGwEzbPmlcmCSWJ2CStG+ex3niwf6ZD89q47Zyh5OgVC
	guSIbRC7rpyO46phKAUMhI0aiSKebw8ksPzg/L/uLswxn2Ty6bRq
X-Gm-Gg: ASbGncuYCJe0vuPvXxdgtFu717GVAitO7YZLqYF0jyzKG9v+Vnxcpp213nlMshNiyuZ
	k+qrgAS0Jm4ONGJXsjqj/knPN31MpJSilro10aURAw0VpnkZxYPB72BLgE52bxg8idgkDHplJw9
	V0r5vcx6rtlkdo/YKnLJHMj/dHrpjh6M+7Esb1ZrLTLfJeR6jW2hxsZNKUTON8NVAScAbNqbmX9
	5nqsdDbRr7dSUFnEVXKxtKua6XyBkRmpXzvg09SljOGNBTs5N4x0uzZZmwp7V/Oi0kM/+MTf4/8
	zg==
X-Google-Smtp-Source: AGHT+IH0pDy/8Q/yEDCk/6/yWnhjHJJVD6DteX7tExEGpoLNyoXJue9k8D2trnyp5eS8Rby+NVII3Q==
X-Received: by 2002:a05:6512:2822:b0:53d:d0a5:aaa9 with SMTP id 2adb3069b0e04-53df00d1b43mr4659348e87.20.1732811067433;
        Thu, 28 Nov 2024 08:24:27 -0800 (PST)
Received: from pc636 (host-95-203-21-235.mobileonline.telia.com. [95.203.21.235])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64310d2sm219032e87.48.2024.11.28.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:24:26 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 28 Nov 2024 17:24:24 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <Z0iZOFAUSqN7cN5Z@pc636>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
 <ZzYsBu_rJWSAcAYf@pc636>
 <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz>
 <Zz3YDI4Bb04opI2d@pc636>
 <a4bd2aef-6402-49e0-9ad6-f353c5200ee7@suse.cz>
 <CA+KHdyXH5X=J2ontChFVUqFx15=VVng23H4gh_o-2Vzfo+mmjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyXH5X=J2ontChFVUqFx15=VVng23H4gh_o-2Vzfo+mmjw@mail.gmail.com>

On Mon, Nov 25, 2024 at 12:18:19PM +0100, Uladzislau Rezki wrote:
> > On 11/20/24 13:37, Uladzislau Rezki wrote:
> > > Thank you. Let me try to start moving it into mm/. I am thinking to place
> > > it to the slab_common.c file. I am not sure if it makes sense to have a
> > > dedicated file name for this purpose.
> >
> > Yeah sounds good. slub.c is becoming rather large and this should not
> > interact with SLUB internals heavily anyway, slab_common.c makes sense.
> > Thanks!
> >
> Got it :)
> 
There is one question. Do you think it works if i do a migration as one
big commit? I am asking, because it is easier to go that way.

If it looks ugly for you, we can use another approach which is to split
the work into several patches and deploy it a series.

--
Uladzislau Rezki
