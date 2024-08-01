Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7313C9A3;
	Thu,  1 Aug 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531436; cv=none; b=NQD6ho/2hv4GIKaF7lJvnKJkXkeIkccTGfvXpj80ka9y1w+GZwjDalcmyWw1pVli+N3m2O0rmiL1LLxLIEmE3ZuJpLk+B9alWNuw8zUMufzTXJz9SAAudQvG8DM1npFq8BkXzbKA/aj8rpKteGC/qjOOlsXcIJTMSd898foqmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531436; c=relaxed/simple;
	bh=RR9wmfLhWBXimo8mBOQnILnGDNzFHTkQco+PprDb4HE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loQ3t080W2khxZaVSsaNehOaqmMsokfcpdVsToZff84brqbGz77QkUZHfmGyBUbPQ3dfAiBEagk0UbhLelwe/nFDKjMSmVaOCgzjlJsMwDkAyJmpDpw87nQQjJmadEz/8DGeXIPvUaJoKrprZ2uaHgIBI0nJK6oVmR3vjVIAGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjMxs2Nl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjMxs2Nl"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f00ad303aso11107825e87.2;
        Thu, 01 Aug 2024 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722531433; x=1723136233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qmz+OO9XTkVCd+ercQ9i3PIjGoG29eQh1VoMeLordk=;
        b=fjMxs2NllDx/+gAd0Yw+urSbfORaAA9GUjfdqnSqDn9bzoz/vBgM58otWoSMoi5M3y
         RxkXVxl0oFynmWkatPqOtEwTLxGVv8QYIochqeyOh54aNy0+kIDqIslrwKzhFlfT5nao
         3xx6Aoo2o5DfPnrxZwI3xCrT7+hzp1X+mYVGPPKQmmU11LuzTWcJEOaujpMzLK8e448N
         AQA000mA/rrA7evblzu7ANZ5fxA/fb7eFoDp8lJzltJdLk3wmxiVijNCylGdNicgGYPZ
         tRpWm7GQz+Vwl+9a6/9BjKbkzLftdipySJjvN8cwfxLVjCMn/xWqbKDrI/KgSkChqu44
         8/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722531433; x=1723136233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qmz+OO9XTkVCd+ercQ9i3PIjGoG29eQh1VoMeLordk=;
        b=ef7Q9148NzNtwUEd1Me1467TNV9lPkkTIjBbbr8dOpM6Ybxa8inNcrXp3T/IJI4Mgl
         2YbQKV11OGz9Vxn5jrUXvJHG/robxbOFPbUUmautjCg6YT39hl61EWRULJAtYT9B38YH
         GcaWydSA0YbGueVD5TaPKOyzbxO+qFzhStjABZI0BL4a/YmqgS0MqXCPkb+jTK932aSf
         MWJfekBHKleKU+DPvE/9iIzcn2q4LH/1f3/kYkJShlwrPUFuv24NcKM6yoPwjfrIIkMN
         kjFTUYx/ivyFv7u5+cxhDPvX4HP5EfOoErN/W/liIyR+nMeTMc3LJiSb4JY3rmepM9mW
         OfAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBGevFB7aA3UTW43BhutCMzxa1j3jnR717LB4bKty6ePfYps32/85HWF9Lckpw8WfvruCMPmX1EaZpYwWAIWOwyNi5FkNWtWx21J3hvQDyEm28W+JqYCJka/JvuqNDuBcI
X-Gm-Message-State: AOJu0YxeO1ZkwkCfSthvNe0LXIEsve2hMAlifOlq7oEx2pr2c2uKT1Pk
	yHADTZP0R2RIu6+anI6U9kyJnVkWjbY96Qfq0O+aKA4Z8GwK3B02
X-Google-Smtp-Source: AGHT+IE7+BdRzS3eKsjshSCy+rOCph2VExOchT69wvgVsdfLQxkmTg0IpMCYch+9eyyPQtgZNKcKQA==
X-Received: by 2002:a05:6512:3d94:b0:52c:dfa7:9f43 with SMTP id 2adb3069b0e04-530bb3a2886mr369788e87.34.1722531432513;
        Thu, 01 Aug 2024 09:57:12 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba1107fsm6724e87.100.2024.08.01.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:57:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 1 Aug 2024 18:57:09 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <Zqu-ZTpksvqxFt0l@pc636>
References: <20240801111039.79656-1-urezki@gmail.com>
 <df34226c-38fc-4cd7-a33c-44a1f714c3da@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df34226c-38fc-4cd7-a33c-44a1f714c3da@suse.cz>

On Thu, Aug 01, 2024 at 04:28:18PM +0200, Vlastimil Babka wrote:
> On 8/1/24 13:10, Uladzislau Rezki (Sony) wrote:
> > Add a kvfree_rcu_barrier() function. It waits until all
> > in-flight pointers are freed over RCU machinery. It does
> > not wait any GP completion and it is within its right to
> > return immediately if there are no outstanding pointers.
> > 
> > This function is useful when there is a need to guarantee
> > that a memory is fully freed before destroying memory caches.
> > For example, during unloading a kernel module.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thanks a lot, Ulad! Locally it makde the kunit test stop failing and for now
> I've pushed it as part of my series for bots to test:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-kfree_rcu-destroy-v2r0
> 
> I hope after RCU folks review I can carry this in my series and later the
> slab git tree so we don't have inter-tree dependencies. Thanks!
> 
You are welcome :)

Yep, if we need to update it i will send out a new version!

--
Uladzislau Rezki
