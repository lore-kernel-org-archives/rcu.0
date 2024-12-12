Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194B189F39;
	Thu, 12 Dec 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030506; cv=none; b=UCgRry95GrfTwciPKIs78eEiPYDT4oV/l0mjNu7Pwo4TnV95M/iA+yDUy7K9wlz4EkGG8WFIYzIBAoIadv5fb2EvnSFdiEhrPRL3N4HdWZWL5X7Ni/dCCzIxTX6O6m4GoIByS7Sb6VW0L0UN9KzbwobSsCQUSVmo2qBH6I7o+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030506; c=relaxed/simple;
	bh=SSbtbjf4N+myf4rI1mNd/z9Tj+QVRdniq1d3DjCN/DA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4y5+qFJs1NrZF0FtOoitmOUkSr3JWjraVbl3VRY8JTF+hXo93w6iATtVkby6GgZhVrlrbHk8JDIkIjNL7Sp2lWPBdAguqNi2o68u4O3n9MjalbaykGcFhsXSiLGGxkng5Z/eJ1vbFdQA9daxnKX13tq1w/sTs1JIFBR7jA4fZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SanTGc+g; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SanTGc+g"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54026562221so987924e87.1;
        Thu, 12 Dec 2024 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734030503; x=1734635303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGQYHU92ndPrpYv/6POn9PHDMPJeDwarv6TQ5xlWAUc=;
        b=SanTGc+gpGZG87CH9L67mMY0Hf6aK0Wc7cGSJsehx6xyrhCV9sX0Am2vTNTR509xMU
         KsMWGzd/e9P5y1k9Y2SmfIH1lxU2B87cNW48/gaYHG1OZjZ1bGgz+nqX5DV4m90JxNTK
         S7tVoVeBxH6+GXsutaZ5wTy4oxjAgj8dmVdrio+XbfaHDZK3xEKwYgsYkT+HpTTUbuyS
         BhjzU5YqDqtuLloDAkLVPVq0rGWySxy81ArmblngZ7oBvyoBK4I6wVwSsLrGShOgo0uL
         NXu9UBtvh8zgJMrmkMms8tdGbE4YmM97CxgQ1L1qcUDsGs7yLLmp7+IoFSUn1HSwYqgG
         XWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030503; x=1734635303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGQYHU92ndPrpYv/6POn9PHDMPJeDwarv6TQ5xlWAUc=;
        b=aqMn6l7sOfnxsAkcoOw8GQIaHm7annmYeyqnt20duemuR/T0q525l8JESWkxGreMtK
         zo4NxMbHY1FlVK16QCW7CQRzD9hL5r32F7orxPE++FziAWHZXKUaBj/RmhI/uS0eBAlr
         N/qgT9IRKABQNg8r1einjRxAHKHLaB87LuNKpGGoq8o4PioQ4CHbqUSTuVzW9VhF/9sU
         bgunTtLTSJwfThwn1mbZDfUmnzGktejb1wzfndMRtMoCfJ3MEbhYlIRJ+O84pFkNQXY5
         +0If7YWqylpIxdiAmmRqb4YCVmCV9LBcpCYodeSelRnMz1/Jn3FyicOOKgze/HFnoxSG
         UrBg==
X-Forwarded-Encrypted: i=1; AJvYcCVazzWVbLRO2l1pPZ8V0j6VgERUmTVyr0HsWmxgsD0lKTkVlhJ/Sn78+ZMUsUoc6nwg31CAn5Dso8r+rJw=@vger.kernel.org, AJvYcCXDM8GQyLLPEu+9InzTP+yuy6KVQiARzwwjT5tFchEdDTZEhN26cPE/dGaI21dmvdQ6WgTh@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmT/KlkfYO4KXlaOJcFp25Xqm/zYxpuul/YuESUGiGKe7sKsX
	pl+93Rs4DgKAaJO0dicX1/oxzRYveNt4nSEFpEZuobkkLRAu5TO3
X-Gm-Gg: ASbGncsjhmesE5MKhk4TujkQZxgVNJjyzIGeRD6NyZGii83TWW5FL6pp8lplhfjUNZp
	RhzkKdqsjgB/FffxaYtHG2Oj0qcBEbNhPwIzAXeJvyS8Sgdvw5x/hXTnTtAeCMUSMmAK9ePey0G
	LH9BdLTDefXqae5ZWRSwqyW/HFggPSlCZ87g0TI9KFnQ6mMtDJtpZvDIaM5MQurzu1ZJAK2pCh2
	WF3QHakhactA9hvj5aJIrU=
X-Google-Smtp-Source: AGHT+IE3zgljXGWu86jNCVPuPy5ygINSrvsgKsVFQBNJzggmWYL0gkJwGiHiS08fe2ObOOBvnhF0HQ==
X-Received: by 2002:a05:6512:220b:b0:540:1c33:ac83 with SMTP id 2adb3069b0e04-540340b6ca4mr533017e87.0.1734030503185;
        Thu, 12 Dec 2024 11:08:23 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f67be1128sm1735397e87.85.2024.12.12.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:08:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Dec 2024 20:08:20 +0100
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <Z1s0pPsGMehOLHWU@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>

On Thu, Dec 12, 2024 at 10:30:28AM -0800, Christoph Lameter (Ampere) wrote:
> On Thu, 12 Dec 2024, Uladzislau Rezki (Sony) wrote:
> 
> > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > here:
> 
> I do not see any use of internal slab interfaces by this code. It seems to
> be using rcu internals though. So it would best be placed with the rcu
> code.
>
I think, later on there will be integration. This is a step forward to place
it under mm where it should be.

--
Uladzislau Rezki
