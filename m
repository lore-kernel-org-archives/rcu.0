Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225818CBFB;
	Thu, 12 Dec 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030832; cv=none; b=ZwftTFGTDngXkgweXK5xGxkXFQxuRXL2R3mIRLdDZBOMuRk3Kxgu9PuGSNOGoNUi3YoOtuOwJNlioBmJGsHZTp8Wpy+ZslpPBZ0TN4kY7xwQUUuR3FpuO6U2dKieXZz2V8yZT0mgMQAgGz+41pZvT5yjj2KAwAntgoubQsC4qx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030832; c=relaxed/simple;
	bh=h94D3kW5ZOJqFQp0kq4dWnkJY0A0SRNZhGLQ3Xu3HvQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnADy9d415GAG+Kr7DZoYrpuNGN0SzzoUE1vE2WEUTuhld+cMJqmvaQN9fzRcwHlan0TkWLjaGVMWLn7R/K1QeUKvnuCP6Of0iWssmUI3xfx9RtOfdDy7EjoEtLS77/WpwqQOwC+sigR4x/8A2tPpmL+Pp6dxlHmtUdgL7BIyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew7M8eOy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew7M8eOy"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401ab97206so984661e87.3;
        Thu, 12 Dec 2024 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734030829; x=1734635629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1rRTr2FehO2b+fK3IlkJQH7gs84ZqkxoQ+IyDQ3ZHs=;
        b=ew7M8eOyMJ96yuebSUQghT006HOvI4C7cfDaCPt0wnxQ2u3ElLvQyOuURr+BcABvNR
         ceTiZXkqoCCn4yBFG17XExsgt1vLzTS3rcnBCQubfToMNGsZUbyf9GYQk+l00gZY7Ury
         P9DO4algwwFofBs9ZPA2pPZdrcbRH2DqnBMz3i2jh9hyXpsfLJK124B4RveRyFRwNkh6
         /0JL/k36Nu48XzIfPxu+fT1qOH4YGZL/zF0NPJ/Ctg8PAwqBZKOCr9z02pdMKABOG8VY
         Qwk+spGsmteELKqKPzqwWqno0fEtLyRoEJqXqspMsz37/kUm3KCD5NTAzyf9WfnRiHPy
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030829; x=1734635629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1rRTr2FehO2b+fK3IlkJQH7gs84ZqkxoQ+IyDQ3ZHs=;
        b=QqrNtsR717SzMhiwEcVRzyFUq12vQNV4nV1KBlmc3AtrQZwqbdeInZYErM3BnmZYkw
         zliMZxVHWoPf58Xu1Lh1MNx9HWrfdd2x/YgspoQ9U1IrX9dH/wDz9/hbdD7sHp2O5Hbs
         ef7yHL6sOVqeNG1TpIMEolwn/8SLjgGApzc6Q6cuUGxTT2UzFcz9v9B+gIM+7LzYeJJ4
         JCSQafojumRO1oTueHb68HEnR8zlLjBUthEGRrTusT6oQ6nJRnwE91jtU7VAExL4uC9W
         AV37lo61ivZxAggCjXMgsvlwSyLPWQKJB5o2B9GBsAWxWJF4rbbiH5K2fWH2NTs5WNe/
         WmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHGtvTAKVDXg/0+iWc576qsj5tMYZUhpsgId5VtxVhaGr6avkg/OMee/ChIjfaqyt1pJbe@vger.kernel.org, AJvYcCVUvprg9SI2qjeqKQlW1AZq9zSNWYR8pGRQ3QNInDMvSDYRB7rpzInr3f4lFpmDOW+nqn9Jw7OBzwM2mVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGekokDA2sm2eW3XomNoEf9jna+s1+eGAU5XCfYbbt3U1z6zj
	QH9iayORCEMajc17hM20eEmm3fUw7qb/Ts1BPAcqoZmHYs9nKWoe
X-Gm-Gg: ASbGncuepg0rWOb/QceKQCSId0FmLD89yWGFF5QvCpsNdKRcw6O4P5PDFKey/ypw4lK
	TMKTi/GnvkySMoyABYM3Am35ArneYM2d9Hn9pZSRdGZpmX8FM8GK0uSeobvoz0osfzI5gwiZ4wp
	K0WvItyItRcnWml56hukZX1PJIsYWaoK/LoeWsK2otinnIPZjCIVWxGjbd/25ht50KresdkKd97
	0OJEIsXYBp2w5cR/IqzuqQ=
X-Google-Smtp-Source: AGHT+IEGx4gfoC+zn2E08+GJgOfyR2s8Z6ruSmpfFxUeCPM5sR4cP2nR3lVpnhSXSc4YZPsPdk+mQw==
X-Received: by 2002:a05:6512:3c87:b0:540:214e:4228 with SMTP id 2adb3069b0e04-540341079dbmr715430e87.16.1734030828400;
        Thu, 12 Dec 2024 11:13:48 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3126b8fesm2077057e87.183.2024.12.12.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:13:47 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 12 Dec 2024 20:13:45 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <Z1s16Vfa326d26h8@pc636>
References: <20241212180208.274813-1-urezki@gmail.com>
 <4f739c61-24c0-3790-8114-988f02c7caea@gentwo.org>
 <ab3c9f52-1643-4dfa-9a04-d6db4dfcf29a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3c9f52-1643-4dfa-9a04-d6db4dfcf29a@paulmck-laptop>

On Thu, Dec 12, 2024 at 11:10:47AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 12, 2024 at 10:30:28AM -0800, Christoph Lameter (Ampere) wrote:
> > On Thu, 12 Dec 2024, Uladzislau Rezki (Sony) wrote:
> > 
> > > This is v2. It is based on the Linux 6.13-rc2. The first version is
> > > here:
> > 
> > I do not see any use of internal slab interfaces by this code. It seems to
> > be using rcu internals though. So it would best be placed with the rcu
> > code.
> 
> That is indeed the current state.  The point of moving it is to later
> take advantage of internal slab state.
> 
And, in fact we already have some integrations. For example a barrier
has been added for slab caches.

--
Uladzislau Rezki
