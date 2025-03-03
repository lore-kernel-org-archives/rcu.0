Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02786238D27;
	Mon,  3 Mar 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021656; cv=none; b=XnHoiN+88In6NG8Y0zbCRxISwPP8aS6xgDDYQihIyV3To8xj81WfUDPDCiGSLpALJdYAU5NgmrkEa+saG2btef/fQOwwmMwTUWqhksO/AYZw3F/5YWoJ2CG/mAAMgj20ZxVoAQs/gb/bqLS5XghYXC6xvURVKMjDnWxKGmBbjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021656; c=relaxed/simple;
	bh=+7aYbhrLmYi1T4KA92FmY4sVW55e+0/xae5106xIhbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx75AkRIeTcf0+dg2tEEcTaJLvSI5lCK6bZTjxrfUeeepzbPqHfkKZelER8tHBs6S+vdMoN06kCaXchDvMc60+H97qH07W414PuXZo+SgWUAqaNLoTxSng9A3qCEWDA+x4u4q0CeDVYJnSFLZ4jk+Tz2T22VUYdmDvfNmTuc60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcbdBpTT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcbdBpTT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ba9825e9so340644085a.0;
        Mon, 03 Mar 2025 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741021654; x=1741626454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RyyaYtBZfDjnmq80BewbVhk3cLDHgbdcz1CFZloCzdE=;
        b=NcbdBpTTsLjIWDnTLZleId5RoheQbhNcknqf2dk2RNmoWC+IrF8qqj9MjmHpaeWeCN
         rhfdC8anZ2KMZX4+Vff5/PzqX9yNeau0dbDQAULU60PYCiDtjsFTc+SfJfy26RtVjiw5
         P8XCRX30umSVSYoQN1Af7sAte0dLsW7cxRZV5MEHSCzDPXsm8tz0xYqo9KB2incmepSQ
         tH6o5CEVa9rrmBGuoq0De6+9qKebfwuOJ+QQAPgX3Y3oACIIzwlIdvlxv9NAf29tAOUd
         nNR9VaiwMca14oJbEcgc32dIbBrD2Di0iR3rjVfgYqKu6IVg2lomC96KBo8pe7G82lTu
         st2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021654; x=1741626454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyyaYtBZfDjnmq80BewbVhk3cLDHgbdcz1CFZloCzdE=;
        b=fh8BCrFFTTt9VC2Wot9t6Ws1H83VUIs6niAGvpkaAvdRIpPzBMFB1KEOb4zwHquUjm
         kY+iu0IJlnFWNRrxpAUfhnURtsp9FUmtX4XL+IQzFohFWizKc+Dh2wIdoSVxvtBfsRgj
         ectuUrVw38cBH1rBTiJ/ATQ3oC7zjPP5HGgTIHh3yxWhXOhg6nHjsKLqoNkCEKjiIMnf
         Dq+nu0SN2bgLondeMVdsT0krvjqE0/aC7UvUHwMAE6q6g3o5Rv+BZEGkjU4/FLlzvFVS
         U995okfzix3bL99cH0n9NB9fI1CYjXExHb/09B7UEFrIZCqpzAkCgyDg10DyP1sUTrnN
         FKCg==
X-Forwarded-Encrypted: i=1; AJvYcCW2IhYzDSzExZOPrVL+AGVvNXG5lF5TOHi5bxKpR6WC0rH/K0nEMerucuZf9kWqSRE3sgYo@vger.kernel.org, AJvYcCXkaVBX484MUUxw072ssSG0yIkyjFvse5aGiut1Emz8KnhKdQkVxlBOo+Xxyfy9PQA9qI0TAhIezfipI/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5u4Kajkz+9kkmWph84fD4ShsCDJYVADbCFMfCJ6GJ5T+UKB75
	Y2SuwXsVZTfIbMMoCMOZohjNwyEW9CG1COumxFfbt0R2iHJHSg8dACISvw==
X-Gm-Gg: ASbGncty+QbKlwHwQ0Nl/wMaEDKUV2GgV5lUaSRG3LmwMz37FNul49HVjQ3/gFv0SZS
	iESfRRgWre1WbMCpMqVpDgJvU/Oxne9x3qWFn5PY2mnq5S5bqVsyaJK4rwYZNP/JIqWjvhhMpPS
	T/UsD/LLZH4hMb1M2M3E5ukCRzcJ0beJJHe51NF+y6Njy3reyqStiGrahJU2fCZmRckRcWIAthh
	KpdTkO88MRWpYNNSeO6avFZMVGtSPb99AQbL3QV24N3YNKkCcKQN9LQA74pLi5Z01BomLHse8VS
	BmIBw4fv6N9emkLCqHHgqJwytk7JH1ujXChU4PJeuEzza6utzmc1ze4K0LCwcgqQkBSBjWbUgBK
	eqz6o2RE/z1UIpl370/tPEC/PJA/tZ7d2zvU=
X-Google-Smtp-Source: AGHT+IF0S4xbV8sQIfxqNVFYsLibdZa96Cj16Xhb94nglhix2yYynx4+0GWLxsG0QpbBU1QWy/Vmvg==
X-Received: by 2002:a05:6214:5098:b0:6e8:8934:337b with SMTP id 6a1803df08f44-6e8a0cfc45cmr212098406d6.14.1741021653786;
        Mon, 03 Mar 2025 09:07:33 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897633e5dsm55170976d6.12.2025.03.03.09.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:07:33 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 01C03120006A;
	Mon,  3 Mar 2025 12:07:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 12:07:33 -0500
X-ME-Sender: <xms:1OHFZ6fUB8iMPjF9HXXREhVgOehMubiA-9G3MocEmWUAtAfUU9NTmg>
    <xme:1OHFZ0OxTViDRMMeUIMNp7-OLgk5iRfym3ZTxMFTj4b1QbldLa2qve0hmGZh2Ob3e
    aI2x4wWt1gKbX5TWg>
X-ME-Received: <xmr:1OHFZ7gDe-HZbt9XGwUasGtPe48YznfAWyBxAMoN5VUedNVOkRYg8dv20Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfdutedvjeeuteeiieejjedtudfhvdff
    vdejhefftdehvedtuefhueehheeigfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehurhgviihkihesghhmrghilh
    drtghomhdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiiiihq
    qhdtuddtfedrhhgvhiesghhmrghilhdrtghomhdprhgtphhtthhopehnvggvrhgrjhdruh
    hprgguhhihrgihsegrmhgurdgtohhmpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:1OHFZ39RO8lPWYJaFTCGiHXSswN5aVnobp7mPy5V6gnmHabR2DVGYg>
    <xmx:1OHFZ2uR0XhjTK_AILKiyjEBGTg28XTtfCyLU42KL0Xx2Z4haE6KUg>
    <xmx:1OHFZ-GoaxNWeF6WyEq4sES5C4Eb_CbdLnYn9Fao53jUQXTdVj1-Ew>
    <xmx:1OHFZ1Ofmj4wwtmoYTFE7PclsvnZsHrDOrUtCvSteLFB3W20D2opDQ>
    <xmx:1OHFZzM1L3b2E5dpuAgJXwcrryv78rALh8zkpG2w7BuDUDWcYtgcXngq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 12:07:32 -0500 (EST)
Date: Mon, 3 Mar 2025 09:07:30 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <Z8Xh0pP4xaFm0nEV@tardis>
References: <Z8HmH85bYNU8enJ2@pc636>
 <dd15fa79-70a5-4929-9339-51a47099c916@paulmck-laptop>
 <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <20250303001710.GA3997787@joelnvbox>
 <20250303170040.GA31126@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303170040.GA31126@joelnvbox>

On Mon, Mar 03, 2025 at 12:00:40PM -0500, Joel Fernandes wrote:
[...]
>=20
> I see the original patch "rcu: Fix get_state_synchronize_rcu_full() GP-st=
art
> detection" is not yet on -next. Once we are convinced about the fix, do we
> want to squash the fix into this patch and have Boqun take it?
>=20

Which "-next" are you talking about? The original patch and the fix is
already in next-20250303 of linux-next:

	https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/lo=
g/?h=3Dnext-20250303&qt=3Drange&q=3D153fc45000e0058435ec0609258fb16e7ea257d2

Regards,
Boqun

> Yet another idea is to apply it for 6.15-rc cycle if more time is needed.
>=20
> Alternatively, we could squash it and I queue it for 6.16 instead of 6.15.
>=20
> And I'm guessing Vlad's series is also for 6.16.
>=20
> thanks,
>=20
>  - Joel
>=20
