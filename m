Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B04FC05027
	for <rcu@archiver.kernel.org>; Fri, 20 Jan 2023 13:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjATNcp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Jan 2023 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjATNco (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Jan 2023 08:32:44 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6B39290
        for <rcu@vger.kernel.org>; Fri, 20 Jan 2023 05:32:43 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-501c3a414acso7686907b3.7
        for <rcu@vger.kernel.org>; Fri, 20 Jan 2023 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtikuj8gXg3ypC8rwxOlgyPtFSBc8FnCeFcbONAIJEg=;
        b=jc6e/Yw01Ua3nKPTtoE6QdlpYh11OawzC5k2RyRlPs9s5T3StuXm5/LmYIJhLKahv/
         2pjv5Bceh+02PEqr8zcjaIYGKKODUMHlKdIIGvtfDosXnDoDWKFN/6g13rmyTkbdhE13
         xPPqGznUq3FWwtM7LeXy7JfhyjA9TBbUky9so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtikuj8gXg3ypC8rwxOlgyPtFSBc8FnCeFcbONAIJEg=;
        b=ldZRxfeVTSeY7gHf4wkbZcqvBasTboZNYaBpzjHLvJyql/YIf7/C0ScG6COo+ewY+Z
         DXnZOW54aqO9EXZPz1PWndwatSwcdvxhGE9yuLq1NzB8nbPnLWPx8ALAYRdt9I+3CZRH
         9PsaEZAyf5uhiPtJ1O7E0ZYa2DHQEp23kSuog6js241IvZ6SNdmQFmf6bscleSqQGLAV
         IAOPEmj4KE/Jc0ZS8wjjLF6LRxbN8yrxdMb7k0+0OplPw3cGKzJ2mB3RR1vtA81LIFCR
         33lvrsrSmu7Wd38V8cHo4Vy5Sqg72M0jx0pzdGkK9U2/eH7yBQ0ww3D2XOfDJeac3Xoo
         UZpQ==
X-Gm-Message-State: AFqh2kq+viLGqP73ueKMlHT2L+13P2akibDhwFn3dily7juOLlcFeBC9
        8p0kXTE5u07dP/+eC7DrE8uIew==
X-Google-Smtp-Source: AMrXdXucZSgAtWPVbcvFfMkOhri9I2bEIntD9GOazgMIFbdwQ3WbLLOEvmS76n4yl9IAjf/TsM5thA==
X-Received: by 2002:a0d:f046:0:b0:364:1ba0:a71a with SMTP id z67-20020a0df046000000b003641ba0a71amr10198880ywe.41.1674221562125;
        Fri, 20 Jan 2023 05:32:42 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006faf76e7c9asm26472941qkl.115.2023.01.20.05.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 05:32:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
Date:   Fri, 20 Jan 2023 08:32:30 -0500
Message-Id: <37171A49-82E9-4008-9B5B-1CEEDC9B653E@joelfernandes.org>
References: <Y8o9Mh1ktK0jdQy9@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Y8o9Mh1ktK0jdQy9@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 20, 2023, at 2:05 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google)=
 wrote:
>> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
>> However, cpu_is_hotpluggable() still returns true for those CPUs. This ca=
uses
>> torture tests that do offlining to end up trying to offline this CPU caus=
ing
>> test failures. Such failure happens on all architectures.
>>=20
>> Fix it by asking the opinion of the nohz subsystem on whether the CPU can=

>> be hotplugged.
>>=20
>> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down().=
 ]
>>=20
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: rcu <rcu@vger.kernel.org>
>> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest=
 of the kernel")
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> Also want to cc: stable on the patch?

Oh sure, sorry. For some reason I thought Sasha and your AI scripts were loo=
king at the Linux-kernel list as well. Or are they, and a Cc to stable is ju=
st to be doubly sure?

> Anyway, for the driver core portion:

Thanks!

 - Joel

>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
