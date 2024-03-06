Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B93692E6
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753247; cv=none; b=Ra5pHNWujuJ7IRpmEk35kL7iXeHAZEyRRtEoIShCdnS+halesk0NaWFT+4bBSIz3rO3A5bd/wgpaiW4RtJbft+LTAsJ3pyl463SrVuCQmCmH8yN+4t6eHTXpV2H9TDIpPe+AdaTj7Pl13xIPfAUneKfE62MItbhadQ8JpM6BTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753247; c=relaxed/simple;
	bh=biMnzxi6lyL4tJNfmpHNxn2LaDWRe4gzMKaFKNTV9dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6OpOoJSdZCtWQk0dhIsM+Id2ljYCRI6qIFRCncVBzkXDUgAlXXG6FMhMUVdQRhIbjZxMJguvWv5h7zPjVlk29wv/SCzHkC7lUERDZJ31WxxAHdFZ9Lpc+2HXkMPopjoSJnlPFQ8PaNLSO9MBC5WzpItd7mkQFmeWHVqwnLLJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a4F5+Yed; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a4F5+Yed"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5135486cfccso49167e87.0
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709753243; x=1710358043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2w7z8ybAhp0MNUwIXPYOARG82rdSVFWAVwXlDOSGiE=;
        b=a4F5+Yedmw2o1YViXTjGIFjp1dnhjAZoNpa/4DrV3c8X0RmNFy68Y4vxrGnt5HmM3P
         Hz0JT4jrnqUJE3wuISJZEpjJfDGl/PJlcajfGPEziwH1mr+81EqD0rcZWffWbISqcD98
         2a6otZkUEPuV7OVkuARvsGu2eo1kCKk2PZTiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753243; x=1710358043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2w7z8ybAhp0MNUwIXPYOARG82rdSVFWAVwXlDOSGiE=;
        b=xGOvN/g6kHBre9siwm6hQ2NSqs+ze0rnIgFEhHuLv4FZ7HHu0uHXsRXRN8UpKTU0TD
         g8XzMLrkoXVfWAJeXx0HPaOYyO87/VHRU0U2x+A/tGGAacsCcTu3s9WijS/Y1pZ5kcNB
         YGD0NQ/b20PSBHpXd9o9SmV4q4HfNnpUijkOBZlU9hugpETyGA0hm1c1LNXBmENmeiej
         GkHWrSCum+zlT03QjxmmAph/OMPiw2VmE2BW0bJxv7WRjRp1oJ8o9BJJKj82ExsOdiBg
         Wylwonr32ZO5NCaO6CutupK2Qaum5XnhUhS930+rTPQeuqOlMj113E+DFsAIO8k1ReVi
         tPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuTNsSiizHqpZlr1G3GOc2co9vEjq3XoCQHlikHAi5/XHc7I8A/hp4WQLxjqOLtmwdh3NhOtavPhiRvZShk85WERSy
X-Gm-Message-State: AOJu0YygPvS5fgCVyp5LDjGDUdMlFD5UO4Ny1bbJNjsWKqHrS4e1hw8B
	EohJ3WHbvMrv40fodFwGXlvC/zX5abIbXUyUHDTOK5hHso7NEMvrewVeAuYLdnG2kds2w+ZOq18
	GlpI=
X-Google-Smtp-Source: AGHT+IFpZFfs8skrNMWYOnPEioMH5+ztlaS4c5/LOepEqNI/g1lua4806JqzohvgYKp4xx3V7mJvow==
X-Received: by 2002:ac2:5b0c:0:b0:512:f472:702f with SMTP id v12-20020ac25b0c000000b00512f472702fmr44553lfn.23.1709753243631;
        Wed, 06 Mar 2024 11:27:23 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25104000000b00512dd6c2de0sm2701685lfb.226.2024.03.06.11.27.21
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:27:22 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so93487721fa.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxmABOSJNvotfkfLrW8TDIBHNAAM28zWQUuC4IdW5TotrW6PljbAZiKtxrsmhXb9jSVVBiaoSX7ijj9aCmzBgVrt1d
X-Received: by 2002:a05:6512:3b9f:b0:512:a4ce:abaa with SMTP id
 g31-20020a0565123b9f00b00512a4ceabaamr54463lfv.48.1709753241495; Wed, 06 Mar
 2024 11:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:27:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
Message-ID: <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In some individual tracing C file where it has a comment above it how
> it's braindamaged and unsafe and talking about why it's ok in that
> particular context? Go wild.

Actually, I take that back.

Even in a random C file, the naming makes no sense. There's no "once" about it.

So if you want to do something like

   #define UNSAFE_INCREMENTISH(x) (WRITE_ONCE(a, READ_ONCE(a) + 1))

then that's fine, I guess. Because that's what the operation is.

It's not safe, and it's not an increment, but it _approximates_ an
increment most of the time. So UNSAFE_INCREMENTISH() pretty much
perfectly describes what it is doing.

Note that you'll also almost certainly end up with worse code
generation, ie don't expect to see a single "inc" instruction (or "add
$1") for the above.

Because at least for gcc, the volatiles involved with those "ONCE"
operations end up often generating much worse code, so rather than an
"inc" instruction, you'll almost certainly get "load+add+store" and
the inevitable code expansion and extra register use.

I really don't know what you want to do, but it smells bad. A big
comment about why you'd want that "incrementish" operation will be
needed.

To me, this smells like "Steven did something fundamentally wrong
again, some tool is now complaining about it, and Steven doesn't want
to fix the problem but instead paper over it again".

Not a good look.

But I don't have a link to the original report, and I'm not thrilled
enough about this to go looking for it.

                  Linus
