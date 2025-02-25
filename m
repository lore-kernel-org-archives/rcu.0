Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F21A0BF1;
	Tue, 25 Feb 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507726; cv=none; b=tV9eZpiUgtYnXqZfMzuPNjkg/Hqj1umcmoyCj7FLLsnD02SNvtAUeZ4NS9BfgA+MRnKOysLnOpcnV+HVajJTUjcPbcRXoB3x4np4d1SQIHHSTUW4BrVnkZ+d5slLn+dtZaE9FEM3tQmlkqaKwykgd+G55XnakRfcxWvMg2Fl4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507726; c=relaxed/simple;
	bh=LcIBQkgMg17c5bKZ9P7Fml126x5/SZoxyvOnnNzAtCY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktoc2IOfi+BUg9ETa9ILbMT8CsxSyx0lQo10jwEX8P7RZ9Bn3lUkOpd4t6F4Iu/dockURaQ2JNGynDrC9nvJa7ZpqjG3FzJJKlGgLAcXZxx7efzCTtFvu9Do0Xl9c3zgdm/cYGHHwfkswdXphsOpNyIn2tHRz6l9mwoRw35DCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcyqtOxh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcyqtOxh"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30797730cbdso58851101fa.3;
        Tue, 25 Feb 2025 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507722; x=1741112522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAEEVhldvoc8F0ob7ntJxWjSZWN8MGyNUwWibkuTCoo=;
        b=bcyqtOxhD3I/JR/sw5pxWBxm/mFsMY5KIW/fS1Dwvh9Wn248X1uBwzyTxukn+LBt8/
         qAu+XvojDlFurnJiyfKFYwDouWla1MACLlgB/7LU44uei7XC7bIwePw/z9Zy9iRe8Lrq
         +5oA2o0fTZocvnmZ1/DxTa18TqPZ+NVUSmFdda3+n6EHNMQYMwY7IJb2FNeunkGec3rQ
         47V6EQjWO4JKG0Zs4oVdg3J8DJi/qTuRKS6SToPjVrUuUsNRDC2To4W4OXQz3yX9jMf5
         OZTWC6XbXWiFELtrSTw6FyJgjuu5uZc3BoKFp3ATCi6qnhvLFF48FpzFoKuYqn4nfRkx
         Kx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507722; x=1741112522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAEEVhldvoc8F0ob7ntJxWjSZWN8MGyNUwWibkuTCoo=;
        b=EgSh+1Gf6gBIYKygS6ufDY66scZ+RYgdPPoIlrzd1rxy3gKoloGDpFOi5P59pXvRM/
         UAInwdAIowm+/J7L+CAf+yooxF2rjMJkWhzmvLL5k1WvGMI3J0QC9HplsoQCx8KRmOdV
         cEXLnNwajLw3RJk6bJnFhkqVW3C9Mf1/YT4KfkvWgoSS8Sx5g/f3mzzlnSt/T2+XOT8f
         xTHF3t8DQpO4Zcsc7lJvc/G8V7PH97XUZ+L6FPl2LB4oAD2jVMDOxqPJTS/RR8TFPdZa
         m1zQdr6JVP3OxviLWnFNY+Rp2/spFCmvj/JZlTiAKw7GSn421hXqjl7OTd8POaaeZeQ7
         Gf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3qJEe2dq2eVSyV5OfF6nH3hUG7E7kRAAb+q1/d+QFnnhHuwiFT9NvseQdyBHsnofoPLVm@vger.kernel.org, AJvYcCXPpDZBK71kwoONwcluBM7FJ3Z3BmdiSqBvkKRAJGYhZWIhVKNZZFlzv0eLbMu5H0vtGhR89BIeI0UWMmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJTo2gxLEfTrR46lREdU2sxLykr8DeoyAy+heugBS+ODl18GK
	FIqwN/DEW4eJPt2OrmuwIFRYOKtUUlW1zMOXWdX7JGXPMUdknCR/
X-Gm-Gg: ASbGnctittAwFd9pys9xcRL/awSvfy5BImuyqGJQ7egaQaAaZ4WojVvzeKckmogWqrs
	R21TFqXpbkPX9MeStsjam79sIpb3B5Sz6TCXY4AvIm0zsn1b23yXGDsOAGpbaU7V/L8+ubny8F/
	+quAsnL4524CN+GlyhI04/R4D72Ce3oXC9Yjgj9oCmg+1omc6jqlngozCDchdlvS35TfPixDkk+
	A3FFiuRufsOmIz5Ko/ouX36soIyFhtrNiPj9keuk83E3wO+M9bTnIw4ium+XBgKKJvvQTA6ThEG
	VIVRQj0CUbq7wE0otSmRx73ngSFC2WvtDCvDVU0xxWeShk5X
X-Google-Smtp-Source: AGHT+IE6+fIcIs/2ApTBgpzTwSR439oiVm+vBAsWtJBpduyP9tKItZO3b2wVdjRM3zH98k0zKDgi3A==
X-Received: by 2002:a05:6512:3ca8:b0:545:576:9df8 with SMTP id 2adb3069b0e04-5493c579f97mr311547e87.26.1740507721477;
        Tue, 25 Feb 2025 10:22:01 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9ee0sm241429e87.219.2025.02.25.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:22:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Feb 2025 19:21:56 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z74KRHzSNbmUJUWt@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <cca361c8-2f03-40b9-872c-0949dc70cde8@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca361c8-2f03-40b9-872c-0949dc70cde8@suse.cz>

On Tue, Feb 25, 2025 at 07:11:05PM +0100, Vlastimil Babka wrote:
> On 2/25/25 18:41, Uladzislau Rezki wrote:
> > 
> > but i had to adapt slightly the Vlastimil's test:
> 
> Great, works for me too, thanks!
> 
Sounds good :)

--
Uladzislau Rezki
