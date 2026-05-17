Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48B3368BF
	for <rcu@vger.kernel.org>; Sun, 17 May 2026 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022080; cv=none; b=Npl9gc2ju3lcW8YXoC9+jGWnapzcWiAEp8jjISxdVVrXO7ghYMQx2C+Tebf9dtYhp/URXYY7/IxBUTX9tgBuZ0CXpuFUFhiTuoPgfe2a6myzubzGPoMsI+AlYBWzvysPd/akS5pT6L5flpnTncsvyqUvubUMP9sDjKnGH1LF1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022080; c=relaxed/simple;
	bh=w+kfh1Dy6u+UktO/Ojj08U2MzX1bLrF0iJTEvIbhID4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdGcAbMmDvrhyj2y6J5dKh0lazoDE7KqUI+shL+rmpD2gYWLBF+zcT5yw0btpEkZFdGS2EMCYqIShJeiAAOSe4Is9NRU9zdyGTyrLD4JwlgKY81icLGL/uM4TzpEjVkS8Kd/10thpBiRj1oZli9ceeiyN9W7q8kBUhWEAlxzUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr6roRvx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr6roRvx"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8cb92f26aso1538393e87.1
        for <rcu@vger.kernel.org>; Sun, 17 May 2026 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779022077; x=1779626877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICmnR9jgJrAJ4e5TLBFpaZ6Ac4G7v2Tf75marMuEa4I=;
        b=Kr6roRvxoyRy9RDyMYvRJ5hI0/XtAQNkLb9onMuvv122Q3qVtJcgXDKY9/ooRkfmNm
         ZxHUY3iGRg+RAiN1I62cZHzoWyxh15+PiKk1OpBnPH+0f7DTYGEg5dvWWBjICW+0zkA+
         2qyHabMivMBxI5QRINBc3ds7qEplXSYtIjYicmYDkeBNSBKk0lb1QqRfTFCj8z9rA2W+
         8umV2vu6PMYXftup8JMFktVDUBzEZdWwRZewLiyNb85WZ/FgtEmmg6dxK0U8WoPCUCvG
         qSD6ChLxNsplgT7wtAspiPfomxmMxkqrWr9MAUzwOPtsn5LQGshCofw3Aa+yRA8VdiVy
         DPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779022077; x=1779626877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICmnR9jgJrAJ4e5TLBFpaZ6Ac4G7v2Tf75marMuEa4I=;
        b=TXy/7Mc4VOk20+DSQCZw4Owh/j1swIAMH6iynFWz6c6CyZp8OZaxFQ/QvhrcDBr8xH
         2gkNY3ohLLBJE9LSwcnrluvus4dHWKRMT9no0pZ2eL6x0ZFDOHb5pnZ5hOWam5/6RbXE
         gvoPEUTZMOIAbILBnN5WuD8dhxlSt5JWtm5N4SMdN4J1rIZj5/CR9Z7HkuuvFl4FFNpl
         UaSdOEWTs/jvZZoUWMaq9tNvcwsR+mBCerH0qeRkkGuWdlncrLxxSMdb1mYjnNfLNDvc
         JUUjhWCxlZrig8veyZtEDJMlHLc4PklvVxL9X6Kj4T2/biem6G1s/Y48mRvxuPaKG+iH
         1how==
X-Forwarded-Encrypted: i=1; AFNElJ/3rjCgawxGLLRXhQ5EaNzi5r3gndH+8ZXpgBRBLE6DR1RqJBcf9hEZMB3KW2k8PLTe+CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAF6XWWNm9OvzaY9+Ap2o+g4UYzAINkagkQEZLGuhdzwv7r6sv
	0Zg2F3d9ulUkw6NZ2LM4iVq5nz5W8b3iM6U8+Q7TV0BgToXVdItLruJ5
X-Gm-Gg: Acq92OFDCAf8HkIwbZZEZRebHZ6OVrmZWy8YKjPEPTtwK7mSbRiBobSpt4X5lobiOWg
	ZFVU/C9QG1Ct+4uZHpHqh+/9Ydb+v9AzSbGm7lVFAE0MrRENGCFmamqR67dOS9zw7HQTrrvbdKt
	TbHbbJ0gb4cpc0/Td3EJStfaSFm35rZQTMOZgvwub3i2LiZSLk0rs75eIWe/vOsZvrxFc7qNmOf
	MHLZNx+6/IZKMXRXxJhS+Ku7rC3LKXAwMzFfVj4VfyefCBJa1M9lX3bDNE1NwQs+wqk99zxwP2G
	h64kijot/t+UaV4wUigSDCsCzdjGEOjHOtoAbOexx9N+kYv8Q88HOgp0sgo1H6NFH6VW/uf/Caa
	uAZZrP/7t8mjmHVls2uBetLclPjvCUGIgQB2SQE/qxnty0IoohHoswJSkqKk+QPJN7IY1K92fxB
	XoFMPctPp5MP8Zahx2/MM=
X-Received: by 2002:a05:6512:10c8:b0:5a8:d1ed:8d4a with SMTP id 2adb3069b0e04-5aa0e747254mr3434370e87.40.1779022077116;
        Sun, 17 May 2026 05:47:57 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500:de96:9acf:5dca:ede4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11a654sm2685723e87.30.2026.05.17.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:47:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 17 May 2026 14:47:55 +0200
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
Message-ID: <agm4-6f-6rOgQPFB@pc636>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
 <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>

On Wed, May 13, 2026 at 12:38:01PM +0200, Thorsten Leemhuis wrote:
> On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > While an srcu_struct structure is in the midst of switching from CPU-0
> > to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > have never been online.  Worse yet, it can attempt in invoke callbacks
> > for CPUs that never will be online, even including imaginary CPUs not in
> > cpu_possible_mask.  This can cause hangs on s390,
> 
> Uladzislau, Paul, according to the fixes tag below this change fixes a
> change that went into 7.0-rc6 -- and apparently causes a "hang" on some
> architectures. So shouldn't this be heading to mainline instead of
> -next? Ideally with a stable tag to ensure backporting to 7.0.y, but
> that is a separate decision?
> 
I assume it will be picked to stable since there is a "Fixes:" tag. From
the other hand i can explicitly update commit message with Cc: stable@vger.kernel.org

Paul, any thoughts?

--
Uladzislau Rezki
