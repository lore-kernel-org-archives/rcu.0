Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57E1D5CE0
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491179; cv=none; b=sonQ3Aoc6jmUMBhZXP22XzNPt0XTZ0p4okqAVH1AoiMCq931dV6XqUyBCCfy80Xo5PYVKeoeHIMurrJNdGc0a7ZRVcMwwitZ/00wmLDxM69yBSX8DQCWgaE9b/kDp6KMaPcRWH1FtPYgYlWWWswN3PFtSR7AQFNgSJ9rxue9ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491179; c=relaxed/simple;
	bh=nvixksGUV3Lm92O/CvnImuwJKwVWgOHbbqeo7NGV3tw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVYchp+QZrX/h/a1bWx6ZBFrwSBXtgtvylvgrhty+aaFOonYSUswj9LQsdwleGZG43h3eUZ+hyAkNUm0EPHtysQ1WxrFv8Ykh3yaYaaYI+G3xEhVJTIyE4eZXqjWkyjYKTrEK3YsM/LQ0h3uRRc6UoulaB5ur1EFdwtcPU0/zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrXXW0vD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrXXW0vD"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a525aedb24so4010106e87.2
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778491176; x=1779095976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzAb7pOrJ1TBgjiTgAbSZx9T1QODcL1eNRhn4IFZjGw=;
        b=KrXXW0vDeFb9chL7eq6S6NDK2Bln1jna5tniBAYDEnUk+d3DX45ShsYNzCK8rxw0F9
         sThFxzhge8e5NlfVmvJlf8JkO8r7JUmXHxzlq9f09266wqdsMOYJwkTb+Ng3sxYCQGo5
         APgL1XZlGQ25b+I8gczj2UJHKVDHbynGYYXKgBz7fohJL2GW5AH0xCoyhXSp5jrjfzH/
         dn42ySQlnw1BpS0qOcnVxy7SsP76VL02zhgFHDBq9j5k7LKi84xdhlLeuSQwQnoFHq8H
         EY3TxlE6sz7ZVXzZXshq6FWzMOEdvh7Y3E7Dykuw807f1MyC8iuh5r/ylSY0VzLbeOPK
         /TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491176; x=1779095976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzAb7pOrJ1TBgjiTgAbSZx9T1QODcL1eNRhn4IFZjGw=;
        b=KNimyaMXGg7G3g22daYsrh+Fsq876/nLRegH66ki34JlROjVje0bwNCLk/KG+mNjE3
         SisvWAtIg2jMsDCeLauGPkYcgO2p0cVBNRrMML25fAjTSkKJ731pZWlppqCr+GyClYWN
         5aogg1bfqoVDdx6WX927y/9wo6bk0ff03olgmQo+l8HPSbYRK9nBOBauxDQrwGJkBgIN
         xviScc3sUBWcEG47Gkm4tVVedoy9RpA3vbfOBR+9NGgoMvQzcp9rXCZNAQDoNp/i/srA
         Wbo9k/sHqVp1lrPRT7pnFaSDWyPoOg+WqT2/C1ZFL7iSev/vzlYFVgT6L8JkD5Ps8f29
         HUEg==
X-Gm-Message-State: AOJu0YwJewgiADjx9PfX1PS6A8f8LVWGocDJAej7lKubb3zmgQNcAEBa
	o65pGbBfIs/oMdtOBk+bevviskFV+MalbGf72xljKAYS2rcz5Cf7IMpO
X-Gm-Gg: Acq92OGiVQ1We7uarK6D6npgERLfVD1mnaG7zO3YMnbiqGadSqdGYFLIqPOuOATEE7O
	qN55m48ny/qTPaPqn0vnFQL+p8sPf32w1YDCtqPv4YGXBai23EE303PZ20Lq3ARjHD5tNn318wU
	8nbQFDAMZby35Gqp2Ah1MzY4tHjtlZmzxUiZ76JZtMXgcpLaZ2yZvgnyimTj752mVc9HBTz6xMu
	vqohEpnZros7iyWP4xeJFQcPUORpXjnAMjbFbaf4akmpAtz9lmRQJfg+qqT2vmt3tNW09eCOz8U
	9Gu+sjB8VfDJr3wQzC9jWJxDJLVfWVYZRtT4BwhSkldwAUHXWbFaAPC88mL9vO/nz+t61lU7ag6
	LsQaptex3aHQet8Lw8zmy2iVzhPxrJtyh1sGbRoji4A89JwDK4UOntcm8ztAhXTJFAKCIC44gIX
	1bPsRQIwzRNkoMZtmoR/IPDex99HyOlJKxLw7auDqjNy2lxQx62gr2yk0OSgz1LA==
X-Received: by 2002:a05:6512:118a:b0:5a8:8db6:b3d with SMTP id 2adb3069b0e04-5a88db611e8mr7741495e87.24.1778491175436;
        Mon, 11 May 2026 02:19:35 -0700 (PDT)
Received: from pc636 (host-95-203-23-125.mobileonline.telia.com. [95.203.23.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm25844851fa.33.2026.05.11.02.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:19:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 May 2026 11:19:32 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 0/6] Miscellaneous RCU changes for v7.2
Message-ID: <agGfJAobdiC5414a@pc636>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
 <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>

On Fri, May 08, 2026 at 10:43:38AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains v2 of the miscellaneous RCU updates for v7.2:
> 
> 1.	Don't queue workqueue handlers to never-online CPUs.
> 
> 2.	Fix kerneldoc header comment typo in srcu_down_read_fast().
> 
> 3.	Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace().
> 
> 4.	Simplify rcu_do_batch() by applying clamp().
> 
> 5.	Simplify param_set_next_fqs_jiffies() by applying clamp_val().
> 
> 6.	Document rcu_access_pointer() feeding into cmpxchg().
> 
> Changes since v1:
> 
> o	Merge the two checkpatch commits (#3 and #4 in v1) into a single
> 	commit (#3).
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/rcupdate.h |   12 +++++++-----
>  b/include/linux/srcu.h     |    2 +-
>  b/kernel/rcu/srcutree.c    |   12 ++++++------
>  b/kernel/rcu/tree.c        |    2 +-
>  b/scripts/checkpatch.pl    |    5 +++--
>  kernel/rcu/tree.c          |    2 +-
>  6 files changed, 19 insertions(+), 16 deletions(-)
> 
Thank you and i have taken v2!

--
Uladzislau Rezki
