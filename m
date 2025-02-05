Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8A22A7F0
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748417; cv=none; b=Q3JszAGswlU+41R7ci73YYgEB9doXdxad5/kJtCxY+UwIEmXt1vniIccManw0gMaK7kVqvd7zHCE/cd8aGTeyDppYsLqeXXpt7uNI264aR/sR5I1HRcNBhDC0Pv7zikDdRxI+i6f/cRyaK60O1YsU9ZZbzXm0qNXMSEkRsy8WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748417; c=relaxed/simple;
	bh=gR3Gag8uRMwQU9Bmdg1HWYiAzoZPs6x1CneAK3Or0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD9UgcxTUj3THgfFhcOzpMLmNfMSpS5h9W5l3cSxBKPXCBB+hDBbDQjDW7zk06tpxFehxJpUipPQwaBEtk+HK8+zA4iQDKIXjGO36UOD9LZdkC6bJFnKdDYJFRAPYEOqSk/coRDNT3f55wxVFugzI3nbXNpWUOM2luL/5dZnnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gooGYVju; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gooGYVju"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f2339dcfdso1800205ad.1
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2025 01:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738748415; x=1739353215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjPw3Npe2yQ2lWhiZcLUlLMtJQlIVo767jAtj+2FQG0=;
        b=gooGYVjuUOJB92c2ts6wcU/AqH6tWXm9u7bOPhp2fjqefHEgkiQWAygZX/RW2ZqsB0
         BQKcR0XS7ui/q5MhR5MhblfXoMc2I1yZ7F/0meog3Oiqlxt+ZfHrn3N6EJr5DJV19YRZ
         GCXc/g1cNJgWhlC9JZOzfCNU/WW5lr3YsSj+zYkFLsOvsd7nkCUcXfmLDGUb+A3wHFc7
         z+7mkX9dmaljT72plewYnjgVwcWVj5k1wHtHT9zatPP1IGu/5b1Cn7vtdnu6ob+W1KhG
         Lc2HhWnFXfdYlSYsSyt+hEjhx9mhfQMXsWNHM69zaKpQiDqcP9lpUnn8TtJ1Yei06SwE
         MTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738748415; x=1739353215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjPw3Npe2yQ2lWhiZcLUlLMtJQlIVo767jAtj+2FQG0=;
        b=Bb0LIdyIXkxSzJ41v2rOcS5gcroiCdPy8Ewf6crRJczm+W7op1YiUErm5hNyjR0UDc
         IeBjFmWu8ohoMY7cPdY2WB73jdSwjzbwInxnxUueLa04FLcbOsTjc88MQdovVd6ibph6
         0BlM5tGZNsM4hr0UnHRfNjTRF1tshKh+AqQ2uUhqKfFD1Q+uEaxfs+x6oMMMxdwZStCX
         pCZzRk9IjPiUiM6U97msG6GOKv/5Pdz3zd3aadkQj9OleQuU7zTcxqbylNQdOyJJi1tq
         h3R8vZiZMkmJGEttx6FWxVnPcbElySv1/7DZKJFq01cVB1S8dKlcGoWWks3lIWnNblNT
         XSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuI7VkbC67bzGprDj/YDS0oUmGD/ZwVAsi2076ahD22L3cj+gPGxVThnOROoABuUJNsfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9h22ouu2Qd7BXV+AB29lCj1S7ondrYzKn9TRCK9E87qJycWA
	ulB8wl7FPojpCENmxznOPrsuZW+Wm/ahICs5MoF7c9iW/KBofEP2
X-Gm-Gg: ASbGnctmJLWJi0ulA7OBHz4S/ABiRma1k5kEHQdU1cxhKJC3156nEHvIOaMi/fgwHRu
	v8LUp8ToXtzOQNiWg1UBhxue4n/YGNOSMTR3slDWxPbzO1nstUwBXXP0ov3Rz2YmxG/5vo/Z4ne
	axOrSuWbxJWZmrJb813B/4A7T+SnhDmtIFgxk4HtcrT4/Ghq+gM4BvsrAijb7dmK6R/JM3+w3xi
	Fw/k76jKjPI3ifvYV945ISA8gEeO0b4DO8Fq/IgZxFzL8xEJcImH4ZWzm8x9gzisrLs/f/ZXRBh
	3HqQmlg9SVUM1zcNmnJsGQF59e6Z0rtXEgmU9nU=
X-Google-Smtp-Source: AGHT+IFrO2QJpwZa8pq9OAx4k3/Zex9zjfUv3ML+kx5UgVe6MF5bN7W/+iPDXo8nUha74fanmD86jg==
X-Received: by 2002:a17:902:eb83:b0:21e:fe55:d3a5 with SMTP id d9443c01a7336-21f01d1584dmr95686435ad.21.1738748414963;
        Wed, 05 Feb 2025 01:40:14 -0800 (PST)
Received: from MacBook-Air-5.local ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe3845d9sm11393548a12.21.2025.02.05.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:40:14 -0800 (PST)
Date: Wed, 5 Feb 2025 18:40:05 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/4] slab: don't batch kvfree_rcu() with SLUB_TINY
Message-ID: <Z6Mx9bEY9dvUTy7Q@MacBook-Air-5.local>
References: <20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz>
 <20250203-slub-tiny-kfree_rcu-v1-4-d4428bf9a8a1@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203-slub-tiny-kfree_rcu-v1-4-d4428bf9a8a1@suse.cz>

On Mon, Feb 03, 2025 at 10:28:50AM +0100, Vlastimil Babka wrote:
> kvfree_rcu() is batched for better performance except on TINY_RCU, which
> is a simple implementation for small UP systems. Similarly SLUB_TINY is
> an option intended for small systems, whether or not used together with
> TINY_RCU. In case SLUB_TINY is used with !TINY_RCU, it makes arguably
> sense to not do the batching and limit the memory footprint. It's also
> suboptimal to have RCU-specific #ifdefs in slab code.
> 
> With that, add CONFIG_KVFREE_RCU_BATCHED to determine whether batching
> kvfree_rcu() implementation is used. It is not set by a user prompt, but
> enabled by default and disabled in case TINY_RCU or SLUB_TINY are
> enabled.
> 
> Use the new config for #ifdef's in slab code and extend their scope to
> cover all code used by the batched kvfree_rcu(). For example there's no
> need to perform kvfree_rcu_init() if the batching is disabled.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Harry
