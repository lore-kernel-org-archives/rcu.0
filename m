Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E11DA53;
	Sat,  8 Jun 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717866055; cv=none; b=RLWcb/FfOq+w0a6EjMrdTC3qoKZAignabGA9VoOrcLeLwEbS2Csu7j4nta2RzPhV4eXDM3NMqrmAVjl22Lx8nzzC7KFgKAGnrzrI/4VtS0cmh8CArqlttTcN0X1YnRSASbyw6DfoGoa51d7Mw6fPqspML+U8EH9QYADlT4s8z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717866055; c=relaxed/simple;
	bh=gMQ0eHLshKtC1hAUhRc+rdSi0rYKPhqCVJ4aIx7Cwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY7HY4zUScElftG9lh+pl4TO5FuaGiPVurx99k1W+1fzIoG6WZ3x85qOLsYcziy0D4B+QU6ho3Mte5H+OTcG4r6OBVX2xpylXQJKLTMr71/TbRfjQ+5FX2Adrqq2ACFoVSfpKlSWvuyr0EZ6VYRDj9g2S/dN3qs9fFvZV5dMGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6SjjxWD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6SjjxWD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b06e63d288so1762956d6.0;
        Sat, 08 Jun 2024 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717866053; x=1718470853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlAvcvuYpizx43siA6da7TpxkmfPkzBdxJMOwCEaWKM=;
        b=X6SjjxWD7tLG6aGJPAvSHQBpdxZVm60ekmA6HzZmzfxVNi9NHj+pfNEiWsDXLeJ6yP
         0SrsRzDyE82YxnsVnqkw1bUxPhvMpPvLImgdwCT031XIIZXBswmgWAXcahyPAtX1w7lL
         n1+HA0SRJurdaqoUWcOyrQLqH+6atnMHAQNBtsOm9PKjoRcs5amLUkNnlX4wXyF6bE6G
         sOWvFTfrB/Jk8LkT7RiupZ5fSG9tiumK9udME2WEtkbqYrdMZ7G/9aoA8ywREIetK7mH
         /smCxNh0dGy+lfnTJkCl762fpEVq3tQ/KzH1BC+LoimRKPRk9aJ2LHAEULJ3NjeW4Air
         b0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717866053; x=1718470853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlAvcvuYpizx43siA6da7TpxkmfPkzBdxJMOwCEaWKM=;
        b=IafB5wZ345LWnTqr5AtbFz3PKduTJHLZMFjvqo+Ci1L2dK/joTWE/5v0N3haeZKZyO
         fdraHMDw8SoRgXkmyuQmqWqnGBWZfixkPx7+YRui5SgpcLfHRHdAAjmZHudHM9z/OGIv
         wQIYL/Tljg6GT1EUQNqCbbolVXigofMR0QvCBKBfxsWZT9WCivKExAhAAuIV90E7w3Br
         OVyhMHfe3ddGK1i4NO+r+3/M+T3saY2o10HKjUjzEVRWyh8Pp1JExAFyLsFyiHT+G+qW
         mkMG8YmaWZTnldvT4NKj8+HuEhp+L7DiOGWdejSG/X/3LvfuipWElHu4WFNlTdhuhc9s
         Qg+g==
X-Forwarded-Encrypted: i=1; AJvYcCUYlivAsQkOeD2QWkrMb6srCZCD2mzl8HUS++upHk1Iuuf4fM4mWYpco6X32ZR03ulP31JnhjxrjFYUxJX4DBO7yjtwXrjsze4wana8lzDNwxIYjdAmmufK4aQ4FcsYOg2A
X-Gm-Message-State: AOJu0Yzef4fvIGJKNUhx+474i8OvNRhuCRSKhr3LbjnZpUmlPf6+KkEk
	H/N+9OiHkRmUddbrwzTaSQnHi8LlO7ZBohaFeDtefBfp4/nU4R5l
X-Google-Smtp-Source: AGHT+IFPUeDnBthizn1ZkGLmlbVW6ag4no8kim6tVOAUEgdPBs8VG+krglvggH6BSVBAK/gK2Is+6Q==
X-Received: by 2002:a0c:aa9b:0:b0:6b0:63dc:eb56 with SMTP id 6a1803df08f44-6b063dceeb7mr38052946d6.62.1717866052917;
        Sat, 08 Jun 2024 10:00:52 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b071aaa3a6sm3974946d6.47.2024.06.08.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 10:00:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8A4F31200043;
	Sat,  8 Jun 2024 13:00:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 08 Jun 2024 13:00:51 -0400
X-ME-Sender: <xms:Q45kZuXIuwo0zkzqFSyaLbyhjXS7tVfYW1VTWqLxEoxf2SIotl7sug>
    <xme:Q45kZqljhFlh7uXLIsT9UtwCphI_qkxe59dowhr-83mFmn8LM27pxkb5v5VHW-WB3
    -L2iBocKr82lY52fA>
X-ME-Received: <xmr:Q45kZiadFHSGNErRj0G2AFDsGo5xW6HqccOMLoZMeOyiZtwosDVP0czCXd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Q45kZlV54gmR6cM4CeZzyU516a1VGq74xKV6J3P8au-Y7eeuPlOCVg>
    <xmx:Q45kZonLD3tyZ0Kn-M_wNOMrLMpRG6xXclF2VhNsz9UqWnxbe-kdag>
    <xmx:Q45kZqdbyYdoZd0GfJMheoh0hNtH1MtFeri963MejbqYfKwoGHwuSg>
    <xmx:Q45kZqGhpXttlXONZmRzToKEvHNC0pdeD1aRYrcUe-fDjC4Oy5LQ0w>
    <xmx:Q45kZmlE2RsU2RRK-Q4L_LkYEbDBja3wKO-WnXTWXzdtFjJw48dzNvSC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 13:00:50 -0400 (EDT)
Date: Sat, 8 Jun 2024 10:00:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
	Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Joel Granados <j.granados@samsung.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
Message-ID: <ZmSONKRjlzJl3WCi@boqun-archlinux>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608120616.GB7947@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608120616.GB7947@redhat.com>

On Sat, Jun 08, 2024 at 02:06:16PM +0200, Oleg Nesterov wrote:
> kernel_wait4() doesn't sleep and returns -EINTR if there is no
> eligible child and signal_pending() is true.
> 
> That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> return false and avoid a busy-wait loop.
> 
> Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
> Reported-by: Rachel Menge <rachelmenge@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Wei, appreciate it if you could share some test result and provide a
Tested-by tag. Thanks!

Regards,
Boqun

> ---
>  kernel/pid_namespace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index dc48fecfa1dc..25f3cf679b35 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -218,6 +218,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	 */
>  	do {
>  		clear_thread_flag(TIF_SIGPENDING);
> +		clear_thread_flag(TIF_NOTIFY_SIGNAL);
>  		rc = kernel_wait4(-1, NULL, __WALL, NULL);
>  	} while (rc != -ECHILD);
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 
