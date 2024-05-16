Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D781509B4
	for <rcu@vger.kernel.org>; Thu, 16 May 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879360; cv=none; b=OjS0QAWa2YUdTY8fEQsBMS6DZD9zE142UVpRexUt3zf6CbXYWtV4cIiN2BHBuvipCndj0N7JEPDAXd6UOBQZu2KMBWg/h6mTi2zGdJtBst3tlryG1RiTEYJB9P0ni2CKfe6/GqFo90rQmV4cUmgQ0+l/ugUt3ZeOAj6uUd+WR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879360; c=relaxed/simple;
	bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rsEiJ9jozHCVvV/75Cx2CgbX3mJs3wZ8m1sobzHjxOsrATyPKXm+ocBqOnIiMN6HjCdhNAcZDtT+e2VFIpgl7Zos/WU8zKPGQY8qXlu+08PfORCUfnyrgARojJIJeUIXdwZZuZ9L+B5xkCPYuEqsodlT9YlhNLebSYFnYO6Lx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pwndxe+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pwndxe+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715879357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
	b=Pwndxe+Ugvq/ja1d4WwmqatZ8MipiVyHLoCWhWXUm61hWoFqbnKmjfGrQ9e1SgnKLBpoY4
	BF+ctJhuBY9upZKf1sqwTyuOxazr+9oyEpiVOecHGKjcNTwnMp8irhO1AGS7phbrNf4Cbg
	52nBCDwTRehwiY93bH8iH6IaT6mwQcg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-79GV8T0iNwOaV6_1uOQxvQ-1; Thu, 16 May 2024 13:09:14 -0400
X-MC-Unique: 79GV8T0iNwOaV6_1uOQxvQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a32d92ca8dso41758506d6.3
        for <rcu@vger.kernel.org>; Thu, 16 May 2024 10:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879352; x=1716484152;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+QuxV+clGRyaVcax9ZlD4uKiSfTKhMUeuT16IR1HLc=;
        b=dGzV7Lq3vel6onhK+ND5Vwx/qYjbHEDJa7s+bB6hO8yr5BguG4AthT2QSQk527vJF2
         Go4B89JC3F0YWaLaKN3r9Pg7xo1150k4xIkaHRNlhoaQaoUnXAJatpWm0FXe8wXGRy3X
         hzJjQdGxXfRezynYrqsdRPdiK9ojmPJiRei9LQOb3uVd2tu9CoD/mvAwbX29l2B/Qb+0
         ZWk0UxQaCEYdEcVs9dvA9xOK2GSFg60DsNkgVL0IHO8Zynggw0BA5o9wAoHHOxxyfYFz
         zMeD/GEuXkAiLXEMkJUbWP8DEofqaY6yrHYBPStJF5Vbyt6D0URjV0q5vwwoqeEfNjzR
         aSEw==
X-Forwarded-Encrypted: i=1; AJvYcCWBalbYsNNdDO7sU+ZLuZYAupJ7eIgIQpsag8TScRrMmqNf0YKY1L/6Nw2bwEXuuQP7skg3xJYnZkRQQUlMq/nvpMtr
X-Gm-Message-State: AOJu0YwqpeWoxa/dMOKAMvS8QvuPGOKJItApAzo9s657OhjNMGcOgwEU
	0ag4HrxTxybzxnL5Qv9kxf16LKJIQgFCy8+pcEHsj3OVVekuDb2j2pmyZmNX73E4IFVNLRIxnT+
	IQJD7Jx0WM6HZtkraZfh6w0BGPrnv9JBK6p4ucWTIM8+4G7iPAiZE7uaClIMJOTw20ybqYfIy3T
	pG9UtWs5wLgY9Wn8tFzH70glEkTGzO8zuIhg==
X-Received: by 2002:a05:6214:5885:b0:6a0:7d91:8752 with SMTP id 6a1803df08f44-6a16825d75bmr223217076d6.58.1715879352144;
        Thu, 16 May 2024 10:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX0nPcN4BilITb6zIiGJi7ggyqJTFHPWgRq6sSz9JUFEtcLXMEaBNnPAb8fRGJNAI5sKxwUg==
X-Received: by 2002:a05:6214:5885:b0:6a0:7d91:8752 with SMTP id 6a1803df08f44-6a16825d75bmr223216646d6.58.1715879351745;
        Thu, 16 May 2024 10:09:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a32f4ae41asm52624336d6.71.2024.05.16.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:09:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
In-Reply-To: <20240515125332.9306-6-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-6-frederic@kernel.org>
Date: Thu, 16 May 2024 19:09:08 +0200
Message-ID: <xhsmh7cftheff.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> RCU stall printout fetches the EQS state of a CPU with a preceding full
> memory barrier. However there is nothing to order this read against at
> this debugging stage. It is inherently racy when performed remotely.
>
> Do a plain read instead.
>
> This was the last user of rcu_dynticks_snap().
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

