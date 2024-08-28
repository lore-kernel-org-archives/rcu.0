Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0042069;
	Wed, 28 Aug 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864418; cv=none; b=cCxhJw9+hne6Tnw1vdZjtprkASbcFGSTFSz0so5uzmGmZVxDvAxgcykHplC+giEvuZestUJ19kwiwKgx4u5I0EThEjGMxGCOU+iF14+xU2+NeC3VsBS3aRTWp2qwFgZwnPcaWAdmHb10pai82KDGGGpOIPF7R18IWlAZE5eF3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864418; c=relaxed/simple;
	bh=hL2BUw9FKx/RRQ6wt6XS4P05jd8TrVesOuVFN+7I1oU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG3LBxMepsWonFc1PNShhyaJSQkl/56Rjdnl3BkYVNch2+pz2rdxnjjvbZxNl53IA6ZPkJKODKfHdnzbuVnYWbyaxhOQLHZtQn1U1xmuz9smwjrS9/iB0x7Oy4oFkEMSlzXEC36U7kuaHBvyXdHmU/mc01KF73Ro1p/gvWp+IxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzY8OotB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzY8OotB"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so8763827e87.1;
        Wed, 28 Aug 2024 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724864415; x=1725469215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiCfj1Oq67SxM4qIo9NQ+6eVV/Q6W8ARR7g05mLThLI=;
        b=IzY8OotBZH2JwO8h7nWDqYFBg3IEHxsqfNswn8zFM25gxIinbq+YxuoGliiotnFpqD
         4j8jllGk5x9YSQyvQiYERQthxpiDqyAgKZed6GARHOo1zHrWkjyw4LiYOsA47jQv4340
         Hk0AuOi4iinMeJVVstK5MIo8m4AYn5kjKFZAYRuR6MS0c2ubooE+4sYTT8zH5GFKG2i/
         JIEoSfBOMWSPKli+Eo6G4thgHtVjkAzMPSpcYaqZ49Ym7xj+1zpxyvBfTC56UEeQkVjk
         30cFEuWKhfxto2ciXY873mGz3p5OGXUW+9dVLJA5iS3oHFWPg6yHOed3i7cPNvvkH7IB
         skgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864415; x=1725469215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiCfj1Oq67SxM4qIo9NQ+6eVV/Q6W8ARR7g05mLThLI=;
        b=ud8+S8iT/88Wj++OAlqHK8EH54xPSu2dZaJp8j6euZGX908sp029F+3gF5lykZ4eP5
         9OgOVhbGoIRd7tI6XUduPuANdd453SSTdU3evevIP3VHT+czxAHPXUge3FCz7NdxzLAo
         RAFVW2NQ4dYSYu+LkseZ438QycLCd+6MZXgzH9KXM3EQIvB3WD4HMJbS7l1upalWYUys
         8Ic5Ldqs51805X/vX5nb/TJO8Bl7Ylpr80LRuIdyuczTyRqE7QTXvGE3w+eIoCadg3SD
         bj58sQPLLwtjP1yX+t/Yi2DTfWffwzDwA+yK1/gu0jb4kfvxe90oeZh61levfyd7/mYh
         8gPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuaYdNi2Hov7ivaJP9/V4uY+Ev5ncmeE519KRXfkKBezAvHpQfInePbOnAtE8S7o96lCnSEov+Dt1O1eo=@vger.kernel.org, AJvYcCXkQHbU9JdntvxF4zoFRPHP3Y/b3vbKy1kI09DsYo3dkl3vob/+dpTC4Kv+KoFZWhpPcRa/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qZJYs5GqxYfe66WpkbgCF1gWVyQBEmH9IMRzy3CoJ0PrV4Y6
	ZWCMF2fu5HBU1GD2RzFZPgKhK13/9/VSTHzJQx+eVfhMdhRfwR8u
X-Google-Smtp-Source: AGHT+IGH5l1KIBnWZWyr3RxBOmmYTpj/YgTxZgck9w++P04yLj2sBv+KaGs0NZbCvHu2BYWrYXhM2Q==
X-Received: by 2002:ac2:4e07:0:b0:52c:d76a:867f with SMTP id 2adb3069b0e04-534387d3ca8mr12098874e87.0.1724864414240;
        Wed, 28 Aug 2024 10:00:14 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea88be3sm2274027e87.252.2024.08.28.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:00:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Aug 2024 19:00:11 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/4] rcu/kvfree: Support dynamic rcu_head for single
 argument objects
Message-ID: <Zs9Xm6VKcpMkWbLE@pc636>
References: <20240828110929.3713-1-urezki@gmail.com>
 <64bebc29-a007-4ebc-bf86-8c2c0a7e6bf6@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64bebc29-a007-4ebc-bf86-8c2c0a7e6bf6@suse.cz>

On Wed, Aug 28, 2024 at 04:58:48PM +0200, Vlastimil Babka wrote:
> On 8/28/24 13:09, Uladzislau Rezki (Sony) wrote:
> > Add a support of dynamically attaching an rcu_head to an object
> > which gets freed via the single argument of kvfree_rcu(). This is
> > used in the path, when a page allocation fails due to a high memory
> > pressure.
> > 
> > The basic idea behind of this is to minimize a hit of slow path
> > which requires a caller to wait until a grace period is passed.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> So IIUC it's a situation where we can't allocate a page, but we hope the
> kmalloc-32 slab has still free objects to give us dyn_rcu_head's before it
> would have to also make a page allocation?
> 
Yes, you understood it correctly :)

>
> So that may really be possible and there might potentially be many such
> objects, but I wonder if there's really a benefit. The system is struggling
> for memory and the single-argument caller specifically is _mightsleep so it
> could e.g. instead go direct reclaim a page rather than start depleting the
> kmalloc-32 slab, no?
> 
This is a good question about benefit and i need to say that i do not
have a strong opinion here. I post this patch to get some opinions about
it. This "dynamic attaching" we discussed with RCU folk a few years ago
and decided not to go with it. I have not found an information why.

The page request path, which is "normal/fast", can lead to a "light"
direct reclaim, if still fails, then we are in a high pressure situation.
Depleting a slab is probably not worth it, especially that the patch in
this series:

[PATCH 4/4] rcu/kvfree: Switch to expedited version in slow path

switches to more faster synchronize_rcu() version to speedup a reclaim.

+ this [PATCH 3/4] rcu/kvfree: Use polled API in a slow path
which also improves a slow path in terms of that a GP might be already
passed for the object being freed.

I am totally OK to drop this patch. This is fine to me.

--
Uladzislau Rezki
