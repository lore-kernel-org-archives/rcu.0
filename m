Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B48C33CAA
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 11:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1380B20882
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 11:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qUXNszkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAULpf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:45:35 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42972 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAULpf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 06:45:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so2290165qtq.9
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2020 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2RAq65fE1p08MEyXCEbcjOGodQ3rvsuPnBMUCzsOXfs=;
        b=qUXNszkrfraMVH0sN6CssRY3CrV5i+a6z/l/iPyFXKM/8qQ+nZF4SmPIVj7nc8xi5K
         Cg97C6gB5Z2+rLZgSMY+ThXdzHxVfecADR654yef5v22MaZprnpqp6X2DJaqq0/SKCIb
         gqU5Wg8+AVJLoZYrR1fBMxsE3OnjiC8DEXP36TivLOWwT8LCboWHo7fGmXDb7EY7weqG
         bfy5kLd7BxFpI+dQ4LOkz3kF8Rwl4oe7P8G958Exlo3j9sL4EuGhVK+xD6pk2X5p42e1
         142xtY9WcoWGAu5objVL+6SJM11kjdO14P5U+nfjaI39YfEjkqAFy5JnstrQeayFrUqg
         0dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2RAq65fE1p08MEyXCEbcjOGodQ3rvsuPnBMUCzsOXfs=;
        b=K8OJSVcZ4qi7pv4hsijPYHPJ45R18J3Fh/bsbMdB3KJcKzGJGpnk/+1BCIQ4NISJi4
         rfXtTE2CP2Hl3Ny2O+GGf3urNg4ObjZ3/WkH+0WrLX4XjRIjXJ8dyZOjPhgc0ll2OaEn
         B+QQ4Fc0YrbVn3OiNeRRRlk6+23qpZxo6bOQCn4/Zw8xAcVV33MRbi1e3ILgGFktwy/G
         Dir8iZEmfiEjGItqrqh5rz0jeqFczldCafNLLceAp0k453+UBMxCxHymYm6ri1FpMiFA
         t62czeWDl3cahWm9c6YB43th7wE5Hi9fGENAzMEBqHgR3vXszWxf+GtzVV8yZEC1oBVC
         11Nw==
X-Gm-Message-State: APjAAAWeb5P1W301fTGetINX8TZPDG3h6wYDp7HAz/qjk6QXElPuhcqH
        ri2oACe6Xqb/xgWaa4OXac0OmdYDK7m99A==
X-Google-Smtp-Source: APXvYqxKEeM+44Nc7BAN0DXttf0/JeAGaenDL9DVvgOTKS/vfhm8fetjaInkx0TGeZ119e12MTEjaw==
X-Received: by 2002:ac8:730c:: with SMTP id x12mr4085646qto.186.1579607134345;
        Tue, 21 Jan 2020 03:45:34 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u52sm19538008qta.23.2020.01.21.03.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:45:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Date:   Tue, 21 Jan 2020 06:45:32 -0500
Message-Id: <D7FEEB19-B519-4AC6-ABA4-250200E2A4E9@lca.pw>
References: <20200121050941.GO2935@paulmck-ThinkPad-P72>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200121050941.GO2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 21, 2020, at 12:09 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> This is what you get when a grace period has been requested, but does
> not start within 21 seconds or so.  The "->state: 0x1ffff" is a new one
> on me -- that normally happens only before RCU's grace-period kthread
> has been spawned.  But by 97 seconds after boot, it should definitely
> already be up and running.
>=20
> Is the system responsive at this point?

Yes, it works fine.

>=20
> Except...  Why is it taking 96 seconds for the system to get to the point
> where it prints "Dentry cache hash table entries:"?  That happens at 0.139=

> seconds on my laptop.  And at about the same time on a much larger system.=

>=20
> I could easily imagine that all sorts of things would break when boot
> takes that long.

I suppose the kernel has CONFIG_EFI_PGT_DUMP=3Dy, so it takes a while to run=
 just before rcu_check_gp_start_stall().=
