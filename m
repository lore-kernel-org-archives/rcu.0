Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71191420B7
	for <rcu@vger.kernel.org>; Fri, 23 Feb 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717015; cv=none; b=q7pWpyhJf/U4fsM/pqg4rAzAjACv8a//ZUxMYjeliRsBKJBBDp8gIRiY+u8qPL/aIViVL4BEEdxnIUrsH7rgXlr9tWo5IRgzydn7US7xtZCzA0PFk5Wl0+Tp3WYrDxbfSStRbxY5R2ZS78oYxnIyqkypNyLFZL9xGrxmEJG0yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717015; c=relaxed/simple;
	bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQvlfU5gujaV/SxscFqidFeOQqIqwALAUtud3mvDbFAu+wTQ35oIbC335KhfLQ6uCKwmOw1A1sMW9FHn3tlh/atPYVxJ3yVP605oTKbwRp2iUhLNP3qI4R+IfGTwPRYUyKHqFsMBPx16cZ5X55JRHj2RYPFutaCWh/sviA0RFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YrSmxdmM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YrSmxdmM"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so8932411fa.1
        for <rcu@vger.kernel.org>; Fri, 23 Feb 2024 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708717012; x=1709321812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
        b=YrSmxdmMWYpMCP7MFEpedL7P+r+lKBaYH8wa7V6aoBnK5Xl1l2+XUnHl91bpWSLsca
         aJjyLc4lKOMHzdnlVyLF5z7Liv/hTQUYvhgFJPPKr37rctyzee5nX+VHeij1q+rviQVz
         tJFGTPZ+lBQ1wAFkfErmP+QWifpmUnENrmblg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708717012; x=1709321812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
        b=erC+61mO0FV9buD52yzIlIGesn2idTD2MxwvIiWlogmhrDGs+/aeiwzeyzcQYCRAbY
         B4v+r0ljPXVpWlOcdAwt25awwtpa0NmU99T5adKxEBJplyA/kXyxMw7kVWLlOM9PKfps
         6MLfT7sadGs2wtpznEc+DOt9GT16AL57WyffD5aqZgJwaLqsn56KkEF5DmcKbkk7CwRP
         MdPjW49C/ZaJwQovh4ZDRxe0I+1eJ5tZBoiHA6AmWsViUQ3Q1iwF9NSbgL0XLfOg3ldz
         WhNnlxx1SL6InN6cfcA8hkwBtOJfQquKgXQudr6YHV4hgU2W4+Sddzklv6eHT5j1ibfv
         xq/w==
X-Forwarded-Encrypted: i=1; AJvYcCUjSnvPkxGsVpt9xMRuVQVum9U7j+whmgpLTAdevj43J3LAWRTTx6FTIANpmLzjZ4LaPba/ysJ1iFp6mCBgQ95WfhxO
X-Gm-Message-State: AOJu0YwnlDLMaFcTF/usNFfNf7P9p+ADG72a1gY4bH269UN/bj0HC9Ky
	UlENEDnUH/pA0gVNnl0jXCA4qYGEuhKj3JBZx1f3q2RYw5KW6owGYUA42HzB35KifYrv0/1jyLj
	Fsrt+hhMT0n+IZ1C9BnOv/6F5qbAysvgAxp3hFQ==
X-Google-Smtp-Source: AGHT+IFMr5HxHcowGDJxIZiF/4hzCTmVH2gW6bkX4Dn1NbwB2kzEAU63dqBByUz+Db5CZXCHyemXbkYWJsh90O/Y8tE=
X-Received: by 2002:a2e:95d2:0:b0:2d2:796b:7e81 with SMTP id
 y18-20020a2e95d2000000b002d2796b7e81mr54494ljh.46.1708717011665; Fri, 23 Feb
 2024 11:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207110951.27831-1-qiang.zhang1211@gmail.com> <2024022359-busboy-empower-900c@gregkh>
In-Reply-To: <2024022359-busboy-empower-900c@gregkh>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 23 Feb 2024 14:36:37 -0500
Message-ID: <CAEXW_YSgDhXzxfrMceceuNBsYap+v-1nXsL4B=5_7s_wKYCWYw@mail.gmail.com>
Subject: Re: [PATCH] linux-5.10/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org, chenzhongjin@huawei.com, 
	rcu@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:15=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Feb 07, 2024 at 07:09:51PM +0800, Zqiang wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> >
> > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
>
> This is not a valid commit in Linus's tree :(
>
> Also, what about 5.4?

Hey Zqiang,

Do you mind resending these backports to stable once it lands in Linus
tree, with the correct commit ID?

I will also apply it to my stable trees so it is not missed in the
future but I appreciate if you can send.

thanks,

 - Joel
