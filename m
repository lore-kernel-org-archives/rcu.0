Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69217839D
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927164; cv=none; b=Rr06HalwuKgod8eHYLOq6/7PWOnsCMi8VMGv3Cmwf+JXgp4CdPb5tnMGTYxlbbZgz9URUks+KXP+KsE0CuuydCF3QBHw/y5n7fNpQnOyybrGuiXmbREuWmsAY9xh05Opdxj7F5Pi0UfF7vz/EMGk19bSoH08JkWPcvpXEzlfxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927164; c=relaxed/simple;
	bh=QfYwzaux6gCZr6/xCy5BBH91hdMa5MXpiQizF3TFAEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9B76yHVyiJn7UQ2plqq/IUXmW6oMVJSV7264FwtgANYysSw3TUirT2GuCHQRkCJgk5C6b0yZ1bDyjPI7V/OPUD5NLPsLGicDplguhAJ0EhboMSk+cYfLRmzbV9XykCnaq75hLJsr+HAgmkxwx8CpdVIvBq/SD3HgQEx1P7fh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ig2JMeLU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ig2JMeLU"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so330958a12.0
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716927160; x=1717531960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiaHSzSrYbERoeBHoK0uviayD0kvIQWFwIWObmnXkLQ=;
        b=Ig2JMeLUYnyCwUzDdWXlalGQ6j2N5DG2+Xpm9lR8sJch8cpb7aiT0Z+rzrelVEh4jM
         sw7xe7tUG6yNBhDlCTkMAwruVXfoCcV4L9rlhOpVZcYvQHeamRYPsaYS2R1aMwPFeEAO
         Ex8UXpgDkL2BoxKEoeOef/pC/WjAlYlyA/VIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927160; x=1717531960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiaHSzSrYbERoeBHoK0uviayD0kvIQWFwIWObmnXkLQ=;
        b=M4yBoKRVcaVMI+eKTDh3eiBQvXDXKNxflV/AiDFeRuOqOO/JtU79W0m2MVXlTPUNc0
         +FHLDBPUXgWXmzxANvhMc4d794bmhsmk1jaiiqcfjbRLRdjR0hOyg3kGMHyAwSG7OUO+
         JzHphjWu4tjAAfhC6RFTdCdWnThumdWoMr/peKlZMZLH6MVT2GUptXjr7+OIBcNbL9dl
         iZeh/lD0IyObuAf32cD3k/azBXVlNGB9dO4WY33J1/nCBSYImu05WWVnAFa/PIKvL0Ta
         kuAfxUKaN7+fGuTpyiiVBAiceBNpe152DBuYck6RjbvteT+gb+OMF8GsCP3jgowpEzRY
         7w3Q==
X-Gm-Message-State: AOJu0Yw0clJOnROyVOlaUCCb7/CbEiRXarEbAWibKBfq8p4Y7xMPjWiU
	TtD5CiJeIhZWAj6iAck7k0jFSLBQsETkEIwq6wRYPdpomxv/4pNykF48Nt6Xu13fTJDFgVbIh9c
	PaM5fSA==
X-Google-Smtp-Source: AGHT+IGMs3LFr5yvWO87bzZskuhxZQ6GVbx8IQH+2bbY99lbokozxtLPhQXg5wzN868T77oOcc5HMA==
X-Received: by 2002:a50:d6c2:0:b0:578:d846:fc0a with SMTP id 4fb4d7f45d1cf-57a04028edamr69380a12.20.1716927160360;
        Tue, 28 May 2024 13:12:40 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bb5ddsm7531073a12.93.2024.05.28.13.12.39
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:12:39 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a352bbd9so28870166b.1
        for <rcu@vger.kernel.org>; Tue, 28 May 2024 13:12:39 -0700 (PDT)
X-Received: by 2002:a17:906:1d50:b0:a5a:8cc0:8c23 with SMTP id
 a640c23a62f3a-a642d954de3mr9923966b.27.1716927159368; Tue, 28 May 2024
 13:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
In-Reply-To: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 13:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHY6hwMr-u8+yMY1HNaM6xDPZzXZkfTBOrFQd0WvJW1w@mail.gmail.com>
Message-ID: <CAHk-=wjHY6hwMr-u8+yMY1HNaM6xDPZzXZkfTBOrFQd0WvJW1w@mail.gmail.com>
Subject: Re: And the v6.11 pull request will come from me
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com, 
	urezki@gmail.com, neeraj.iitr10@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 10:09, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Please let me know of any questions or concerns.

Ack, all sounds good.

And it wasn't a problem last time either, I just wanted to make it
clear that I don't want to randomly pull from new people without
having some kind of hand-over.

And everybody reacted very quickly with a "yup, all good" (which I
obviously _expected_ it to be - I just wanted the explicit ack), so
all it did was delay my pull request by literally a couple of minutes.

I was going to write that it delayed things by "a few hours", but I
went back and checked: I asked for a handoff confirmation email at
9:38, and I got your reply at 9:46, and my merge commit is dated 9:49,
all the same morning.

So it literally delayed things by like 11 minutes on a pull request
that was nice and timely.

This was all the opposite of a problem. Just an oversight that worked
out very quickly.

In fact, even in my "I really want to see proper heads-up" email I also wrote:

  [ I should have reacted to this earlier, but I just put all the "for
    6.10" pull requests in the queue without looking closer ]

so quite arguably even that 11-minute delay was my fault for not
having reacted when the original pull request came in, and only
reacting once the merge window started and I started processing it.

               Linus
