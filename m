Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E17C83F10
	for <rcu@archiver.kernel.org>; Sun, 27 Aug 2023 22:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjH0Wch (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 27 Aug 2023 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjH0WcK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 27 Aug 2023 18:32:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C43127
        for <rcu@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962535808so40184161fa.0
        for <rcu@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=pDJpdZu2j/cEXI8q96VLCQehou6Za8fh3mId760yxzJO2TnQy5gHmHKY41s5tcPqfR
         Qh4u8AN57Gy3uxviVCylc2qNfwx+f/yhFNRh7ejFTlbjcKXhidmqqeiFh4pW4yEK3pZR
         m/XC5VxK84eHhLinGlXYFTi31Gs1ngOI5lDnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=YaOzbF9qWPR3sWQ+RPpk06C67ETPmaRCkmKhUuhO/zS3Rh0282C2rkowmKihUetqc3
         qspj+Nq1yYeCWuleRfiafn64coVYd/0qOclm1SlhgcRAeWpc0EWQc2W0zJWpYmSI5a4q
         echZBm/rA3C6Mfqa+4AHFj4Mbx2anj+8wzu6QWNctY+vEWafYfT5mGIWFQlyfCbSSpHo
         ELz4j65wHePgDjicikzW/iwrK32DBVF7fuxVlBaIusZWgNnxIF7MAx7YH0y0qmpnPNK7
         kSyBfoW0JSJODhHlMpQVoJsNaarCH/3ejT+kdqons/1lEjBhclTcN0+oPVXJB4BstoQG
         xACA==
X-Gm-Message-State: AOJu0YwKL+IaRrijTLVtY4g/DAHX+ry2d1eezCPXyBuV8DqAjiRB9joU
        DIKTbSmlHQoXdCLtbGI/Dox4/S1tvpBU/nXjp8/L2g==
X-Google-Smtp-Source: AGHT+IHtdDrMRNrQ66FFvPjFeqlziiP+ZqGr7K+9yBmVWjejtYIy0dZEjeTvNTOwXLa2Qp8rkcr8i5ZyL/UT9eRgCBw=
X-Received: by 2002:a2e:96d7:0:b0:2bc:d09c:853a with SMTP id
 d23-20020a2e96d7000000b002bcd09c853amr12863293ljj.6.1693175525928; Sun, 27
 Aug 2023 15:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230827215741.246948-1-joel@joelfernandes.org> <2023082812-pampers-uptown-69a2@gregkh>
In-Reply-To: <2023082812-pampers-uptown-69a2@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 27 Aug 2023 18:31:55 -0400
Message-ID: <CAEXW_YTP9mm2f5YEL=Dbr399KomN6jd8Rwx+N1MXOuefs-vzoA@mail.gmail.com>
Subject: Re: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 27, 2023 at 6:27=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 27, 2023 at 09:57:39PM +0000, Joel Fernandes (Google) wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > [ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]
>
> I don't see this commit in Linus's tree, am I just missing it somewhere?
>

Ah, this particular patch might not be in Linus's tree yet. It is in
Paul's tree. Feel free to ignore it for now if you want and I'll
resend it later (and likewise for the 5.10 one).

thanks,

 - Joel
