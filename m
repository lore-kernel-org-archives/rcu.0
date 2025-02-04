Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A43203710
	for <rcu@vger.kernel.org>; Tue,  4 Feb 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703190; cv=none; b=uJJgnKbKPb0xX8qeYyh4GR/te1JvOPVInplcJecNPKSmVpcAFg7uIefQ5/SN8ltpqVpI6OXAfg7gcB4liAVn2BRdTORoANtBCZYC39mPtMcZPGpA4lAHOTA2lrwTnlf9wxkAUst5egr7mQ0aTu3izOe0WB72wr9S+aEe2ULObz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703190; c=relaxed/simple;
	bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1aN7uiP8pfzn5kTYpjr1aKUQTqWWO6ucjFPSalDzvdpguSwqeCO1W4JosWrWU9TIfIx+yd7Ret6Mw22tgPyIndUcZi2dB0U0mNsZjWqxk87E20y2mk5qWGDnoTTVQDIBhr4I8Q06WqDUsk29agU91cQaIs/abFBc9uN1qkhfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BydzdPmn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BydzdPmn"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso12347126a12.1
        for <rcu@vger.kernel.org>; Tue, 04 Feb 2025 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738703187; x=1739307987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
        b=BydzdPmnV9BbJ9B9Jvl31hbFH/TiXwRZrf12Evt9431E7FIKVYAI/TLIXMsgq3EPE1
         HLw/+IAhyXMAYkgmJp9k++sKtGgiGurPzedQglrCSjJn+21W4yBR05vVBBOJdo3+a+KM
         tvx3fzf/++30sWWDpa363pd4KwLyp9TseNzQq/NdBY87czLA2VCz1SB/p6n4qEFx/qb6
         Rk3D9au9h4ZgiOOqZrdzSxGxIrOhuEyYbzwlaCr16Em/6Scp11iA5EEloTwT8TPg3kE/
         1ktmEUwF9n9OHP/iBc/3PHdUXH7iO7ralpeqyAB8xEOzdlH3xAQN3Tu1/DSi/2DlKT4l
         5XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738703187; x=1739307987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2VMy/mZSzVsFKXSsZuubqeCO4lUt3dAhrwJRPjUpXM=;
        b=nAmvTNUjO/PCYe9sYs6uCxHJk2GN5T4qXUH3MeYUkWhadV+YAUAGsk2Woqz0v/Ri+6
         YB5KYAUQWupOiGoYOzH4tNB1BDzKeuhpfugT5vW8xN+izinz9jkD6HPtLYI1d3/cRnk5
         2SaYTPH/t+Cq2ayj2J/AZYWtM/ZyLB/wtp9Q1A0B6OMWJ0AAixzeaiz73laRVUWyX8nb
         rvYrJtYsAk3TSL2MN2zhbUatK+CZ13QU58ZYPn2oPvoavMWT6qP83bxm2s55UJfyS+JO
         rHEECcqXGucJt361WQlUnbnNlTwIMetjZV6OTyulhOlRgJXo5+KZI4QWK43sVwV41s3U
         TTUw==
X-Forwarded-Encrypted: i=1; AJvYcCUjaB/4KJByT3Y6QdI4RVPPPLV1YU5LlbtpmU6km2nZXTq8pN9mRKFveCT/gRahkQdM4hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4VOeWi+ts25+l3cEFv5xT/eAb6JpmFUaAf1JjlKFXQtfXUQQ
	C4ZdAkRTsn7r3iPcThtLKRDHbmUE2WF6vJcbLBT1kpAG473J42Kd3UWuAOLyvK5YWcKqRU4lvOL
	0h3G7Sthk8EEtUE4hAESrgaFCsvFij1q9EHT4
X-Gm-Gg: ASbGncsdWl7ukTXRYMroJmm4/PkMGEZpQGDUeDJ/T8gt8WD37Pv3d6XnAPf//bZ7BZ/
	+5AqwNObEdPl1wGmJoqlauwDEHNvjmXhe1GbJlCWoL34v4pMcDKIWO6dAovTct80Etgwc680=
X-Google-Smtp-Source: AGHT+IEtEZKGE1oy0fcpkv2AoGMFCaGgcR18DmbgunCWXKy4NrQYvAa0oQ7lmY0F9kj5vkiIWyvaL+6FgzWRCb837Ws=
X-Received: by 2002:a05:6402:350c:b0:5dc:100c:1569 with SMTP id
 4fb4d7f45d1cf-5dcdb71bb52mr618193a12.13.1738703186554; Tue, 04 Feb 2025
 13:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com> <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org> <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org>
In-Reply-To: <20250204130025.33682a8d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 22:06:15 +0100
X-Gm-Features: AWEUYZk4qe_FfPMCq9gukGi8MnE0qNu_kvmk9tAtTwPpeFmc3PiBgaIn7zHubLk
Message-ID: <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 4 Feb 2025 21:10:59 +0100 Eric Dumazet wrote:
> > > Test output:
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp=
-sh/
> > > Decoded:
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-cras=
h-thr2-0
> >
> > Oh well. So many bugs.
>
> TBH I'm slightly confused by this, and the previous warnings.
>
> The previous one was from a timer callback.
>
> This one is with BH disabled.
>
> I thought BH implies RCU protection. We certainly depend on that
> in NAPI for XDP. And threaded NAPI does the exact same thing as
> xfrm_trans_reinject(), a bare local_bh_disable().
>
> RCU folks, did something change or is just holes in my brain again?

Nope, BH does not imply rcu_read_lock()
